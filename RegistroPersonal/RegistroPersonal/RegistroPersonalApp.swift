//  RegistroPersonalApp.swift
//  RegistroPersonal
//  Created by Narciso Meza on 10/02/22.

import SwiftUI

@main
struct RegistroPersonalApp: App {
    
    @State var staffLst: [Employee] = []
    
    @ObservedObject var model = SwiftUIViewCModel.shared
    
    var body: some Scene {
        WindowGroup {
            if model.state == .listStaff{
                ListStaff(staffLst: $staffLst)
            }else if model.state == .detailStaff{
                DetailStaff(staffLst: $staffLst)
            }
        }
    }
}
