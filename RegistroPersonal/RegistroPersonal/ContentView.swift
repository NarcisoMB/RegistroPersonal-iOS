//  ContentView.swift
//  RegistroPersonal
//  Created by Narciso Meza on 10/02/22.

import SwiftUI

struct ContentView: View {
    var staffLst: [Employee] = [Employee(id: UUID().uuidString, area: "Software", name: "Narciso", stlastName: "Meza", ndLastName: "Baltazar", phone: 4775812770, dateBirth: "10/26/1995", email: "ncismeba@gmail.com")]
    
    var body: some View {
        VStack{
            List{
                Section(header: Text("Empleados")) {
                    ForEach(staffLst){employee in
                        Text(employee.name)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    print("\(employee.name) is being deleted.")
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button(role: .cancel) {
                                    print("\(employee.name) is being edited.")
                                    
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                            }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
