//  SQLite.swift
//  RegistroPersonal
//  Created by Narciso Meza on 11/02/22.

import Foundation
import SQLite

let databaseFileName = "dbtest.sqlite3"
let databaseFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(databaseFileName)"

func ConnectToDB() -> Bool {
    do {
        let _ = try Connection(databaseFilePath)
        return true
    }catch{
        print(error)
        return false
    }
}

func CreateTable() -> Bool {
    do {
        let db = try Connection(databaseFilePath)
        
        let employees = Table("employees")
        let id = Expression<String>("id")
        let area = Expression<String>("area")
        let name = Expression<String>("name")
        let stLastName = Expression<String>("stLastName")
        let ndLastName = Expression<String>("ndLastName")
        let phone = Expression<String>("phone")
        let dateBirth = Expression<String>("dateBirth")
        let email = Expression<String>("email")
        
        try db.run(employees.create { t in
            t.column(id, primaryKey: true)
            t.column(area)
            t.column(name)
            t.column(stLastName)
            t.column(ndLastName)
            t.column(phone)
            t.column(dateBirth)
            t.column(email)
        })
        // CREATE TABLE "users" (
        //     "id" INTEGER PRIMARY KEY NOT NULL,
        //     "name" TEXT,
        //     "email" TEXT NOT NULL UNIQUE
        // )
        return true
    } catch {
        print (error)
        return false
    }
}

func InsertIntoDB(){
    do{
        let db = try Connection(databaseFilePath)
        
        let employees = Table("employees")
        let id = Expression<String>("id")
        let area = Expression<String>("area")
        let name = Expression<String>("name")
        let stLastName = Expression<String>("stLastName")
        let ndLastName = Expression<String>("ndLastName")
        let phone = Expression<String>("phone")
        let dateBirth = Expression<String>("dateBirth")
        let email = Expression<String>("email")
        
        let insert = employees.insert(id <- "1234rtgfdsw345", area <- "software", name <- "Narciso", stLastName <- "Meza", ndLastName <- "Baltazar", phone <- "(477) 581-2770", dateBirth <- "1995-10-26 11:00:00", email <- "ncismeba@gmail.com")
        try db.run(insert)
        // INSERT INTO "users" ("name", "email") VALUES ('Alice', 'alice@mac.com')
    }catch{
        print(error)
    }
}
func SelectFromDB() -> Array<Employee> {
    
    var staffLst: [Employee] = []
    
    do{
        let db = try Connection(databaseFilePath)
        
        let employees = Table("employees")
        let id = Expression<String>("id")
        let area = Expression<String>("area")
        let name = Expression<String>("name")
        let stLastName = Expression<String>("stLastName")
        let ndLastName = Expression<String>("ndLastName")
        let phone = Expression<String>("phone")
        let dateBirth = Expression<String>("dateBirth")
        let email = Expression<String>("email")
        
        let dateFormatter = DateFormatter()
        
        for employee in try db.prepare(employees) {
            print("id: \(employee[id]), area: \(employee[area]), name: \(employee[name]), stLastName: \(employee[stLastName]), ndLastName: \(employee[ndLastName]), phone: \(employee[phone]), dateBirth: \(employee[dateBirth]), email: \(employee[email])")
            // id: 1, name: Optional("Alice"), email: alice@mac.com
                    
            staffLst.append(Employee(id: employee[id], area: employee[area], name: employee[name], stLastName: employee[stLastName], ndLastName: employee[ndLastName], phone: employee[phone], dateBirth: dateFormatter.date(from: employee[dateBirth]), email: employee[email]))
            print(staffLst)
        }
        return staffLst
        // SELECT * FROM "users"
    }catch{
        print(error)
        if CreateTable(){
            _ = SelectFromDB()
            return staffLst
        }else{
            _ = SelectFromDB()
        }
        return staffLst
    }
}

func UpdateToDB(){
    do{
        let db = try Connection(databaseFilePath)
        
        let employees = Table("employees")
        let id = Expression<String>("id")
        let area = Expression<String>("email")
        let name = Expression<String>("name")
        let stLastName = Expression<String>("email")
        let ndLastName = Expression<String>("email")
        let phone = Expression<String>("email")
        let dateBirth = Expression<String>("email")
        let email = Expression<String>("email")
        
        let nar = employees.filter(id == "")
        
        try db.run(nar.update(area <- area.replace("", with: "")))
        try db.run(nar.update(name <- name.replace("", with: "")))
        try db.run(nar.update(stLastName <- stLastName.replace("", with: "")))
        try db.run(nar.update(ndLastName <- ndLastName.replace("", with: "")))
        try db.run(nar.update(phone <- phone.replace("", with: "")))
        try db.run(nar.update(dateBirth <- dateBirth.replace("", with: "")))
        try db.run(nar.update(email <- email.replace("", with: "")))
        // UPDATE "users" SET "email" = replace("email", 'mac.com', 'me.com')
        // WHERE ("id" = 1)
    }catch{
        print(error)
    }
}

func DeleteFromDataBase(){
    do {
        let db = try Connection(databaseFilePath)
        
        let employees = Table("employees")
        let id = Expression<String>("id")
        
        let nar = employees.filter(id == "rowid")
        
        try db.run(nar.delete())
        // DELETE FROM "users" WHERE ("id" = 1)
        
    }catch{
        print(error)
    }
}

// try db.scalar(employees.count) // 0
// SELECT count(*) FROM "users"
