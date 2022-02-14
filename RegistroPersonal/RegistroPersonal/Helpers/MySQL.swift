//  MySQL.swift
//  RegistroPersonal
//  Created by Narciso Meza on 13/02/22.

import Foundation
import OHMySQL

func createTableMySQL(){
    Constants.coordinator.encoding = .UTF8MB4
    Constants.coordinator.connect()
    
    let context = MySQLQueryContext()
    context.storeCoordinator = Constants.coordinator
    
    let queryString = "CREATE TABLE vbm2uuxxcscf4x3i.users ( id varchar(100) NULL, area varchar(100) NULL, name varchar(100) NULL, stLastName varchar(100) NULL, ndLastName varchar(100) NULL, phone varchar(100) NULL, email varchar(100) NULL, dateBirth varchar(100) NULL)"
    let queryRequest = MySQLQueryRequest(query: queryString)
    try? context.execute(queryRequest)
}

func dropTableMySQL(){
    
    Constants.coordinator.encoding = .UTF8MB4
    Constants.coordinator.connect()
    
    let context = MySQLQueryContext()
    context.storeCoordinator = Constants.coordinator
    
    let dropQueryString = "DROP TABLE users"
    let dropQueryRequest = MySQLQueryRequest(query: dropQueryString)
    try? context.execute(dropQueryRequest)
}

func insertTableMySQL(staff: Employee){
    
    Constants.coordinator.encoding = .UTF8MB4
    Constants.coordinator.connect()
    
    let context = MySQLQueryContext()
    context.storeCoordinator = Constants.coordinator
    
    let queryString = "INSERT INTO vbm2uuxxcscf4x3i.users (id, area, name, stLastName, ndLastName, phone, dateBirth, email) VALUES('\(staff.id)', '\(staff.area)', '\(staff.name)', '\(staff.stLastName)', '\(staff.ndLastName)', '\(staff.phone)', '\(staff.dateBirth)', '\(staff.email)');"
    let queryRequest = MySQLQueryRequest(query: queryString)
    try! context.execute(queryRequest)
    
}

func fetchTableMySQL() -> Array<Employee>{
    
    var staffLst: [Employee] = []
    
    Constants.coordinator.encoding = .UTF8MB4
    Constants.coordinator.connect()
    
    let context = MySQLQueryContext()
    context.storeCoordinator = Constants.coordinator
    
    let queryString = "SELECT * FROM vbm2uuxxcscf4x3i.users;"
    let queryRequest = MySQLQueryRequest(query: queryString)
    staffLst = try! context.executeQueryRequestAndFetchResult(queryRequest) as! [Employee]
    
    return staffLst
}

func updateTableMySQL(staffList: [Employee]){
    
    Constants.coordinator.encoding = .UTF8MB4
    Constants.coordinator.connect()
    
    let context = MySQLQueryContext()
    context.storeCoordinator = Constants.coordinator
    
    for staff in staffList {
        let queryString = "UPDATE vbm2uuxxcscf4x3i.users SET area='\(staff.area)', name='\(staff.name)', stLastName='\(staff.stLastName)', ndLastName='\(staff.ndLastName)', phone='\(staff.phone)', dateBirth='\(staff.dateBirth)', email='\(staff.email)' WHERE id='\(staff.id)';"
        let queryRequest = MySQLQueryRequest(query: queryString)
        try! context.execute(queryRequest)
    }
    
}
