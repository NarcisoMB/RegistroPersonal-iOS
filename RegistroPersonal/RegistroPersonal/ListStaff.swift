//  ListStaff.swift
//  RegistroPersonal
//  Created by Narciso Meza on 10/02/22.

import SwiftUI

struct ListStaff: View {
    
    @Binding var readOnly: Bool
    @Binding var staff: Employee
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
                                    staffLst.remove(at: staffLst.firstIndex(of: employee)!)

                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button() {
                                    staff = employee
                                    model.state = .detailStaff
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button() {
                                    readOnly = true
                                    staff = employee
                                    model.state = .detailStaff
                                } label: {
                                    Label("View", systemImage: "eye")
                                }
                                .tint(.blue)
                            }
                    }
                }
            }
            .navigationBarTitle("Lista Empleados")
            .navigationBarItems(
                leading:
                    Button(action: {

                    }){
                        Label("Add", systemImage: "arrow.counterclockwise.icloud")
                    },
                trailing:
                    Button(action: {
                        model.state = .detailStaff
                    }){
                        Label("Add", systemImage: "plus")
                    }
            )
            .onAppear(){
                
            }
        }
    }
}
