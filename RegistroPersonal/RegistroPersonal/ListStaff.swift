//  ListStaff.swift
//  RegistroPersonal
//  Created by Narciso Meza on 10/02/22.

import SwiftUI

struct ListStaff: View {
    
    @Binding var staffLst: [Employee]
    
    @ObservedObject var model = SwiftUIViewCModel.shared
    
    var body: some View {
        NavigationView {
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
            .navigationBarTitle("Lista Empleados")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        model.state = .detailStaff
                    }){
                        Label("Add", systemImage: "plus")
                    }
            )
            .onAppear(){
                if staffLst.count == 0 {
                    staffLst.append(Employee(id: UUID().uuidString, area: "Software", name: "Narciso", stlastName: "Meza", ndLastName: "Baltazar", phone: 4775812770, dateBirth: Date.now, email: "ncismeba@gmail.com"))
                }
            }
        }
    }
}
