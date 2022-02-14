//  MySQL.swift
//  RegistroPersonal
//  Created by Narciso Meza on 13/02/22.

import Foundation
import OHMySQL

func fetchData(){
    let userData = MySQLConfiguration(user: "y8p4b3rcv7vw4vlo", password: "e3rgl5vcl5tw57c9", serverName: "18.207.39.42", dbName: "vbm2uuxxcscf4x3i", port: 3306, socket: "/mysql/mysql.sock")
    let coordinator = MySQLStoreCoordinator(configuration: userData)
    coordinator.encoding = .UTF8MB4
    coordinator.connect()
    
    let context = MySQLQueryContext()
    context.storeCoordinator = coordinator
    
    let queryString = "SELECT * FROM vbm2uuxxcscf4x3i.users;"
    let queryRequest = MySQLQueryRequest(query: queryString)
    let response = try? context.executeQueryRequestAndFetchResult(queryRequest)
    print(response)
}
