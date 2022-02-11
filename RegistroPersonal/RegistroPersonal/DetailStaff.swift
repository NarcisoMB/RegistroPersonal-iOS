//  DetailStaff.swift
//  RegistroPersonal
//  Created by Narciso Meza on 10/02/22.

import SwiftUI

struct DetailStaff: View {
    
    enum Field: Int, CaseIterable {
        case name, stlastName, ndLastName, email, phone
    }
    
    @State var name: String = ""
    @State var area: String = ""
    @State var stlastName: String = ""
    @State var ndLastName: String = ""
    @State var dateBirth: Date = Date.now
    @State var email: String = ""
    @State var phone: Int!
    
    @FocusState var isInputActive: Bool
    @FocusState var focusedField: Field?
    
    @ObservedObject var model = SwiftUIViewCModel.shared
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre", text: $name)
                    .onSubmit { focusedField = .stlastName }
                    .focused($focusedField, equals: .name)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .submitLabel(.next)
                    .toolbar(content: {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button(action: {
                                focusedField = focusedField.map {
                                    Field(rawValue: $0.rawValue - 1) ?? .phone
                                }
                                focusedField.map {
                                    print($0.rawValue)
                                }
                            }){
                                Image(systemName: "chevron.up")
                            }
                            Button(action: {
                                focusedField = focusedField.map {
                                    Field(rawValue: $0.rawValue + 1) ?? .name
                                }
                                focusedField.map {
                                    print($0.rawValue)
                                }
                            }){
                                Image(systemName: "chevron.down")
                            }
                            Spacer()
                            Button("Hide") { isInputActive = false }
                        }
                    })
                TextField("Apellido Paterno", text: $stlastName)
                    .focused($focusedField, equals: .stlastName)
                    .onSubmit { focusedField = .ndLastName }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .submitLabel(.next)
                TextField("Apellido Materno", text: $ndLastName)
                    .focused($focusedField, equals: .ndLastName)
                    .onSubmit { focusedField = .email }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .submitLabel(.next)
                TextField("Email", text: $email)
                    .focused($focusedField, equals: .email)
                    .onSubmit { focusedField = .phone }
                    .keyboardType(.emailAddress)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .submitLabel(.next)
                TextField("Telefeno", value: $phone, formatter: NumberFormatter())
                    .focused($focusedField, equals: .phone)
                    .padding(.horizontal, 16)
                    .keyboardType(.phonePad)
                    .padding(.vertical, 8)
                Picker("Area", selection: $area) {
                    Text("Software").tag("software")
                    Text("Consultoria").tag("consultoria")
                    
                }
                .pickerStyle(.segmented)
                DatePicker("Pick a date", selection: $dateBirth, in: Date()..., displayedComponents: [.date])
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            }
            .navigationBarTitle("Agregar Empleados")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        model.state = .listStaff
                    }){
                        Text("Agregar")
                    }
            )
        }
        .onAppear {
            self.isInputActive = true
            self.focusedField = .name
        }
    }
}

struct DetailStaff_Previews: PreviewProvider {
    static var previews: some View {
        DetailStaff()
    }
}
