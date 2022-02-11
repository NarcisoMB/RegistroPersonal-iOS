//  Employee.swift
//  Employee
//  Created by Narciso Meza on 10/02/22.

import Foundation

struct Employee: Identifiable, Equatable {
    var id: String
    var area: String
    var name: String
    var stlastName: String
    var ndLastName: String
    var phone: String
    var dateBirth: Date
    var email: String
    
    init(id: String, area: String, name: String, stlastName: String, ndLastName: String, phone: String, dateBirth: Date, email: String) {
        self.id = id
        self.area = area
        self.name = name
        self.stlastName = stlastName
        self.ndLastName = ndLastName
        self.phone = phone
        self.dateBirth = dateBirth
        self.email = email

    }
}
