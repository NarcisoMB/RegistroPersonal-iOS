//  DetailStaff.swift
//  RegistroPersonal
//  Created by Narciso Meza on 10/02/22.

import SwiftUI
import iPhoneNumberField


struct DetailStaff: View {
    
    enum Field: Int, CaseIterable {
        case name, stLastName, ndLastName, email, phone
    }
    
    @Binding var readOnly: Bool
    @Binding var staff: Employee
    @Binding var staffLst: [Employee]
    
    @State var name: String = ""
    @State var area: String = ""
    @State var stLastName: String = ""
    @State var ndLastName: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var dateBirth: Date = Date.now
    @State private var showAlert = false
    
    @FocusState var focusedField: Field?
    
    @GestureState private var dragOffset = CGSize.zero
    @ObservedObject var model = SwiftUIViewCModel.shared
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre", text: $name)
                    .focused($focusedField, equals: .name)
                    .onSubmit { focusedField = .stLastName }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .submitLabel(.next)
                    .disabled(readOnly)
                    .onAppear(perform: {
                        name = staff.name == "" ? name : staff.name
                    })
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
                TextField("Apellido Paterno", text: $stLastName)
                    .focused($focusedField, equals: .stLastName)
                    .onSubmit { focusedField = .ndLastName }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .submitLabel(.next)
                    .disabled(readOnly)
                    .onAppear(perform: {
                        stLastName = staff.stLastName == "" ? stLastName : staff.stLastName
                    })
                TextField("Apellido Materno", text: $ndLastName)
                    .focused($focusedField, equals: .ndLastName)
                    .onSubmit { focusedField = .email }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .submitLabel(.next)
                    .disabled(readOnly)
                    .onAppear(perform: {
                        ndLastName = staff.ndLastName == "" ? ndLastName : staff.ndLastName
                    })
                TextField("Email", text: $email)
                    .focused($focusedField, equals: .email)
                    .onSubmit { focusedField = .phone }
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .submitLabel(.next)
                    .disabled(readOnly)
                    .onAppear(perform: {
                        email = staff.email == "" ? email : staff.email
                    })
                HStack{
                    Text("Telefono")
                        .padding(.leading, 12)
                    iPhoneNumberField("Phone", text: $phone)
                        .maximumDigits(10)
                        .focused($focusedField, equals: .phone)
                        .padding(.horizontal, 16)
                        .padding(.trailing, 8)
                }
                .disabled(readOnly)
                HStack{
                    Text("Area")
                        .padding(.leading, 12)
                        .padding(.trailing, 32)
                    Picker("Area", selection: $area) {
                        Text("Software").tag("software")
                        Text("Consultoria").tag("consultoria")
                        
                    }
                    .disabled(readOnly)
                    .pickerStyle(.segmented)
                    .onAppear(perform: {
                        area = staff.area == "" ? area : staff.area
                    })
                }
                DatePicker("Fecha de Nacimiento", selection: $dateBirth, displayedComponents: [.date])
                    .disabled(readOnly)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .onAppear(perform: {
                        dateBirth = staff.dateBirth == nil ? Date.now : staff.dateBirth
                    })
            }
            .navigationBarTitle(staff.id.isEmpty ? (readOnly ? "Detalle Empleado" : "Agregar Empleados") : "Modificar Empleado")
            .navigationBarItems(
                leading:
                    Button(action: {
                        staff = Employee()
                        readOnly = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        model.state = .listStaff
                    }){
                        Image(systemName: "chevron.left")
                    },
                trailing:
                    Button(action: {
                        showAlert = true
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        print(staff)
                        if (area == "" || name == "" || stLastName == "" || ndLastName == "" || phone == "" || dateBirth == Date.now) {
                            
                        }else{
                            if !(staff.id.isEmpty) {
                                let index = staffLst.firstIndex(of: staff)!
                                staffLst[index].area = area
                                staffLst[index].name = name
                                staffLst[index].stLastName = stLastName
                                staffLst[index].ndLastName = ndLastName
                                staffLst[index].phone = phone
                                staffLst[index].dateBirth = dateBirth
                                staff = Employee()
                            }else{
                                staffLst.append(Employee(id: UUID().uuidString, area: area, name: name, stLastName: stLastName, ndLastName: ndLastName, phone: phone, dateBirth: dateBirth, email: email))
                                staff = Employee()
                            }
                        }
                        model.state = .listStaff
                    }){
                        if !(readOnly) {
                            Text("Guardar")
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Empleado Agregado."))
                    }
            )
        }
        .onAppear(perform: {
            print("Empleado\n\(staff)")
            phone = staff.phone == "" ? phone : staff.phone
        })
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                staff = Employee()
                readOnly = false
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                model.state = .listStaff
            }
        }))
    }
}
