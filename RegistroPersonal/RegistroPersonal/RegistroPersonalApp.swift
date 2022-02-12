//  RegistroPersonalApp.swift
//  RegistroPersonal
//  Created by Narciso Meza on 10/02/22.

import SwiftUI

@main
struct RegistroPersonalApp: App {
    
    @State var readOnly = false
    @State var staff = Employee()
    @State var staffLst: [Employee] = []
    
    @ObservedObject var model = SwiftUIViewCModel.shared
    
    init(){
        if ConnectToDB(){
            staffLst = SelectFromDB()
            print("\n\nLista empleados\n\n\(staffLst)\n\n")
            if staffLst.count == 0 {
                staffLst.append(Employee(id: UUID().uuidString, area: "software", name: "Narciso", stLastName: "Meza", ndLastName: "Baltazar", phone: "(477) 581-2770", dateBirth: Date.now, email: "ncismeba@gmail.com"))
            }
        }
//        InsertIntoDB()
    }
    
    var body: some Scene {
        WindowGroup {
            if model.state == .listStaff{
                ListStaff(readOnly: $readOnly, staff: $staff, staffLst: $staffLst)
            }else if model.state == .detailStaff{
                DetailStaff(readOnly: $readOnly, staff: $staff, staffLst: $staffLst)
            }
        }
    }
}
