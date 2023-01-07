//
//  LoginView.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 27.12.2022.
//

import SwiftUI

/// View for user sign in and sign up
struct AccountLoginView: View {
    
    @StateObject var model = LoginViewModel()
    
    enum Field: Int {
        case name = 1
        case email = 2
        case password = 3
        case passwordRepeat = 4
    }
    @FocusState var focusedField: Field?
    
    var body: some View {
        
        VStack {
            
            // Logo and title
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(minHeight: 0, maxHeight: 100)
                Group {
                    Text("Zákaznický účet")
                        .font(.title)
                        .bold()
                    Text("Uložte si oblíbené produkty, získejte nabídky na míru a sledujte stav Vaší objednávky.")
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.vertical, 20)
            
            // Form
            Group {
                if model.createNewAccount {
                    TextField("Jméno a příjmení", text: $model.name)
                        .focused($focusedField, equals: .name)
                        .textContentType(/*@START_MENU_TOKEN@*/.name/*@END_MENU_TOKEN@*/)
                        .submitLabel(.next)
                }
                TextField("Email", text: $model.email)
                    .textContentType(/*@START_MENU_TOKEN@*/.emailAddress/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                
                SecureField("Heslo", text: $model.password)
                    .textContentType(model.createNewAccount == true ? .newPassword : .password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(model.createNewAccount ? .next : .done)
                if model.createNewAccount {
                    SecureField("Heslo znovu", text: $model.passwordRepeat)
                        .textContentType(.newPassword)
                        .focused($focusedField, equals: .passwordRepeat)
                        .submitLabel(.done)
                }
            }
            .textFieldStyle(OutlineTextFieldStyle())
            .onSubmit {
                focusNextField()
            }
            
            // Error
            if model.error != nil {
                HStack {
                    Spacer(minLength: 0)
                    VStack {
                        Text(model.error!)
                            .bold()
                    }
                    Spacer(minLength: 0)
                }
                .padding()
                .background {
                    Color.red
                }
                .cornerRadius(8)
            }
            
            Spacer()
            
            // Secondary button
            Button(model.createNewAccount == true ? "Přihlásit se ke stávajícímu účtu" : "Vytvořit nový účet") {
                model.createNewAccount.toggle()
            }
            
            // Main button
            Button {
                focusedField = nil
                model.login()
            } label: {
                if model.isProcessing {
                    ProgressView()
                } else {
                    Text(model.createNewAccount == true ? "Zaregistrovat se" : "Přihlásit se")
                }
            }
            .buttonStyle(LargeButtonStyle())
        }
        .padding()
        .background(Color("BackgroundColor"))
    }
    
    func focusNextField() {
        focusedField = Field(rawValue: focusedField!.rawValue+1)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AccountLoginView()
            .preferredColorScheme(.dark)
    }
}
