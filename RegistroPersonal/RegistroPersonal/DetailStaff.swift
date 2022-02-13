//  DetailStaff.swift
//  RegistroPersonal
//  Created by Narciso Meza on 10/02/22.

import SwiftUI
import iPhoneNumberField


struct DetailStaff: View {
    
    let dateFormatter = DateFormatter()
    
    enum Field: Int, CaseIterable {
        case name, stLastName, ndLastName, email, phone
    }
    
    @Binding var readOnly: Bool
    @Binding var staff: Employee
    @Binding var staffLst: [Employee]
    
    @State var spaces = ""
    @State var name: String = ""
    @State var area: String = ""
    @State var stLastName: String = ""
    @State var ndLastName: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var dateBirth: Date = Date.now
    @State private var successfulInsertion = false
    @State private var emptySpaces = false
    
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
                                }){
                                    Image(systemName: "chevron.up")
                                }
                                Button(action: {
                                    focusedField = focusedField.map {
                                        Field(rawValue: $0.rawValue + 1) ?? .name
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
                        dateFormatter.dateFormat = "y-MM-dd HH:mm:ss"
                        dateBirth = (dateFormatter.date(from: staff.dateBirth) == nil ? Date.now : dateFormatter.date(from: staff.dateBirth))!
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
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        if (area == "" || name == "" || email == "" || stLastName == "" || ndLastName == "" || phone == "" || dateBirth == Date.now) {
                            
                            spaces = ""
                            
                            spaces = name == "" ? spaces + "\nNombre" : spaces
                            spaces = stLastName == "" ? spaces + "\nApellido Paterno" : spaces
                            spaces = ndLastName == "" ? spaces + "\nApellido Materno" : spaces
                            spaces = phone == "" ? spaces + "\nTelefono" : spaces
                            spaces = email == "" ? spaces + "\nCorreo Electronico" : spaces
                            spaces = area == "" ? spaces + "\nArea" : spaces
                            spaces = !(staff.id.isEmpty) ? spaces : ((Calendar.current.isDate(dateBirth, equalTo: Date.now, toGranularity: .day)) ? spaces + "\nFecha de Nacimiento" : spaces)
                            
                            emptySpaces = true
                        }else{
                            if !(staff.id.isEmpty) {
                                
                                var newStaff = Employee()
                                
                                print("Formatter\n\(dateFormatter.string(from: dateBirth))")
                                
                                newStaff.area = area
                                newStaff.name = name
                                newStaff.stLastName = stLastName
                                newStaff.ndLastName = ndLastName
                                newStaff.phone = phone
                                newStaff.email = email
                                newStaff.dateBirth = dateFormatter.string(from: dateBirth)
                                
                                print("Original\n\(staff)\nNuevo\n\(newStaff)")
                                
                                _ = UpdateToDB(staff: staff, newStaff: newStaff)
                                print("Salio del Update")
                            }else{
                                staff = Employee(id: UUID().uuidString, area: area, name: name, stLastName: stLastName, ndLastName: ndLastName, phone: phone, dateBirth: dateFormatter.string(from: dateBirth), email: email)
                                successfulInsertion = InsertIntoDB(staff: staff)
                            }
                            staff = Employee()
                            model.state = .listStaff
                        }
                    }){
                        if !(readOnly) {
                            Text("Guardar")
                        }
                    }
                    .alert(isPresented: $successfulInsertion) {
                        Alert(title: Text("Empleado Agregado."))
                    }
                    .alert(isPresented: $emptySpaces) {
                        Alert(title: Text("Campos Vacios"), message: Text("Error en los siguientes campos:\(spaces)"), dismissButton: .default(Text("Ok")))
                    }
            )
        }
        .onAppear(perform: {
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
