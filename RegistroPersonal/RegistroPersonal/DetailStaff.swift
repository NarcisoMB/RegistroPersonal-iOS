//  DetailStaff.swift
//  RegistroPersonal
//  Created by Narciso Meza on 10/02/22.

import SwiftUI
import iPhoneNumberField


struct DetailStaff: View {
    
    enum Field: Int, CaseIterable {
        case name, stlastName, ndLastName, email, phone
    }
    
    @Binding var staffLst: [Employee]
    
    @State var name: String = "Narciso2"
    @State var area: String = "software"
    @State var stlastName: String = "Meza"
    @State var ndLastName: String = "Baltazar"
    @State var dateBirth: Date = Date.now
    @State var email: String = "ncismeba@gmail.com"
    @State var phone: String = ""
//    @ObservedObject var phoneInput = TextLimiter(limit: 11)

    
    @FocusState var focusedField: Field?
    
    @ObservedObject var model = SwiftUIViewCModel.shared
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre", text: $name)
                    .focused($focusedField, equals: .name)
                    .onSubmit { focusedField = .stlastName }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .submitLabel(.next)
                    .toolbar(content: {
                        ToolbarItemGroup(placement: .keyboard) {
                            HStack{
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
                                Button("Listo") {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            }
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
                    .autocapitalization(.none)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .submitLabel(.next)
                iPhoneNumberField("Phone", text: $phone)
                    .flagHidden(false)
                    .flagSelectable(true)
                    .maximumDigits(10)
                    .focused($focusedField, equals: .phone)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                Picker("Area", selection: $area) {
                    Text("Software").tag("software")
                    Text("Consultoria").tag("consultoria")
                    
                }
                .pickerStyle(.segmented)
                DatePicker("Pick a date", selection: $dateBirth, displayedComponents: [.date])
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            }
            .navigationBarTitle("Agregar Empleados")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        model.state = .listStaff
                        staffLst.append(Employee(id: UUID().uuidString, area: area, name: name, stlastName: stlastName, ndLastName: ndLastName, phone: phone, dateBirth: dateBirth, email: email))
                    }){
                        Text("Agregar")
                    }
            )
        }
    }
}
