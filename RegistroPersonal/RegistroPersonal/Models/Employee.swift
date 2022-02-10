//  Employee.swift
//  Employee
//  Created by Narciso Meza on 10/02/22.

import Foundation

struct Employee: Identifiable, Codable {
    var id: String
    var area: String
    var name: String
    var stlastName: String
    var ndLastName: String
    var phone: Int
    var dateBirth: String
    var email: String
        
}
