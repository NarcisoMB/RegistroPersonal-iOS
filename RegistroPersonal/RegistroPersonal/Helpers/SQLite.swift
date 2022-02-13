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

func InsertIntoDB(staff: Employee) -> Bool {
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
        
        let insert = employees.insert(id <- staff.id, area <- staff.area, name <- staff.name, stLastName <- staff.stLastName, ndLastName <- staff.ndLastName, phone <- staff.phone, dateBirth <- staff.dateBirth, email <- staff.email)
        try db.run(insert)
        return true
        // INSERT INTO "users" ("name", "email") VALUES ('Alice', 'alice@mac.com')
    }catch{
        print(error)
        return false
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
        
        for employee in try db.prepare(employees) {
            print("id: \(employee[id]), area: \(employee[area]), name: \(employee[name]), stLastName: \(employee[stLastName]), ndLastName: \(employee[ndLastName]), phone: \(employee[phone]), dateBirth: \(employee[dateBirth]), email: \(employee[email])")
            // id: 1, name: Optional("Alice"), email: alice@mac.com
                    
            staffLst.append(Employee(id: employee[id], area: employee[area], name: employee[name], stLastName: employee[stLastName], ndLastName: employee[ndLastName], phone: employee[phone], dateBirth: employee[dateBirth], email: employee[email]))
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

func UpdateToDB(staff: Employee, newStaff: Employee) -> Bool {
    print("Entro al Update")
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
        
        let employee = employees.filter(id == staff.id)
        
        try db.run(employee.update(area <- area.replace(staff.area, with: newStaff.area)))
        try db.run(employee.update(name <- name.replace(staff.name, with: newStaff.name)))
        try db.run(employee.update(stLastName <- stLastName.replace(newStaff.stLastName, with: staff.stLastName)))
        try db.run(employee.update(ndLastName <- ndLastName.replace(newStaff.ndLastName, with: staff.ndLastName)))
        try db.run(employee.update(phone <- phone.replace(staff.phone, with: newStaff.phone)))
        try db.run(employee.update(dateBirth <- dateBirth.replace(staff.dateBirth , with: newStaff.dateBirth)))
        try db.run(employee.update(email <- email.replace(staff.email, with: newStaff.email)))
        // UPDATE "users" SET "email" = replace("email", 'mac.com', 'me.com')
        // WHERE ("id" = 1)
        return true
    }catch{
        print(error)
        return false
    }
}

func DeleteFromDataBase(staff: Employee){
    do {
        let db = try Connection(databaseFilePath)
        
        let employees = Table("employees")
        let id = Expression<String>("id")
        
        let employee = employees.filter(id == staff.id)
        
        try db.run(employee.delete())
        // DELETE FROM "users" WHERE ("id" = 1)
        
    }catch{
        print(error)
    }
}

// try db.scalar(employees.count) // 0
// SELECT count(*) FROM "users"
