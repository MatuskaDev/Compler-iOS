//
//  AccountSettingsView.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 03.01.2023.
//

import SwiftUI

struct AccountSettingsView: View {
    
    @ObservedObject var userManager = UserManager.shared
    
    @State var isProcessing = false
    
    // Textfield bindings
    @State var newName = ""
    @State var emailPassword = ""
    @State var newEmail = ""
    @State var changePasswordCurrent = ""
    @State var newPassword = ""
    @State var newPasswordRepeat = ""
    
    // Alert bindings
    @State var showSuccessAlert = false
    @State var showErrorAlert = false
    @State var alertError: String?
    
    var body: some View {
        ColoredList {
            LabeledSection("Změna jména") {
                HStack {
                    TextField(userManager.user?.name ?? "Nové jméno", text: $newName)
                        .textContentType(.name)
                    Button {
                        changeName()
                    } label: {
                        ButtonLabel(isProcessing: isProcessing)
                    }
                    .disabled(newName == "" || newName == userManager.user?.name)
                }
            }
            
            LabeledSection("Změna emailu") {
                HStack {
                    VStack {
                        SecureField("Vaše heslo", text: $emailPassword)
                            .textContentType(.password)
                        TextField(userManager.user?.email ?? "Nový email", text: $newEmail)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                    }
                    Button {
                        changeEmail()
                    } label: {
                        ButtonLabel(isProcessing: isProcessing)
                    }
                    .disabled(newEmail == "" || newEmail == userManager.user?.email)
                }
            }
            
            LabeledSection("Změna hesla") {
                
                SecureField("Stávající heslo", text: $changePasswordCurrent)
                    .textContentType(.password)
                HStack {
                    VStack {
                        SecureField("Nové heslo", text: $newPassword)
                            .textContentType(.newPassword)
                        SecureField("Nové heslo znovu", text: $newPasswordRepeat)
                            .textContentType(.newPassword)
                    }
                    Button {
                        changePassword()
                    } label: {
                        ButtonLabel(isProcessing: isProcessing)
                    }
                    .disabled(changePasswordCurrent == "" || newPassword == "" || newPasswordRepeat == "")
                }
            }
        }
        .navigationTitle("Nastavení")
        // Success aler
        .alert("Úspěšně změněno", isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) {}
        }
        // Error alert
        .alert("Nastala chyba", isPresented: $showErrorAlert, presenting: alertError, actions: { _ in
            Button("OK", role: .cancel) {}
        }, message: { error in
            Text(error)
        })
    }
    
    struct ButtonLabel: View {
        
        var isProcessing: Bool
        @Environment(\.isEnabled) var isEnabled
        
        var body: some View {
            if isProcessing && isEnabled {
                ProgressView()
            } else {
                Text("Změnit")
            }
        }
    }
}

// MARK: Functions
extension AccountSettingsView {
    
    func changeName() {
        DatabaseManager.shared.setUserName(newName)
        showSuccessAlert = true
        newName = ""
    }
    
    func changeEmail() {
        withAnimation {
            isProcessing = true
        }
        Task {
            do {
                try await userManager.changeEmail(newEmail: newEmail, password: emailPassword)
                DispatchQueue.main.async {
                    self.showSuccessAlert = true
                    self.emailPassword = ""
                    self.newEmail = ""
                }
            } catch {
                DispatchQueue.main.async {
                    self.alertError = error.localizedDescription
                    self.showErrorAlert = true
                }
            }
            
            DispatchQueue.main.async {
                withAnimation {
                    isProcessing = false
                }
            }
        }
    }
    
    func changePassword() {
        withAnimation {
            isProcessing = true
        }
        
        if newPassword == newPasswordRepeat {
            Task {
                do {
                    try await userManager.changePassword(newPassword: newPassword, currentPassword: changePasswordCurrent)
                    DispatchQueue.main.async {
                        showSuccessAlert = true
                        changePasswordCurrent = ""
                    }
                } catch {
                    DispatchQueue.main.async {
                        alertError = error.localizedDescription
                        showErrorAlert = true
                    }
                }
                
                DispatchQueue.main.async {
                    newPassword = ""
                    newPasswordRepeat = ""
                    
                    withAnimation {
                        isProcessing = false
                    }
                }
            }
        } else {
            alertError = "Nová hesla se neshodují"
            showErrorAlert = true
            newPassword = ""
            newPasswordRepeat = ""
            
            withAnimation {
                isProcessing = false
            }
        }
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
            .preferredColorScheme(.dark)
    }
}
