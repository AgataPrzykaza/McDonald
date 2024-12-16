//
//  LoginView.swift
//  McDonald
//
//  Created by Agata Przykaza on 08/10/2024.
//

import SwiftUI
import FirebaseAuth

@Observable final class LoginViewModel{
    var email: String = ""
    var password: String = ""
    var errorMessage: String?
    var showError: Bool = false
    var hidePasswordFieldOpacity: Bool = true
    

    
    func login() async {
            do {
                try validateInput()
                
                try await performLogin()
               
            } catch {
                
                errorMessage = error.localizedDescription
            }
        }

        private func validateInput() throws {
            guard email.contains("@") else { throw AutheticationError.invalidEmail }
            guard password.count >= 6 else { throw AutheticationError.invalidPassword }
            
            
        }

        private func performLogin() async throws {
            do {
                    let authResult =  try await AuthManager.shared.signInUser(email: email, password: password)
                } catch let error as NSError {
                    switch error.code {
                            case AuthErrorCode.operationNotAllowed.rawValue:
                        throw AutheticationError.noSuchUser
                            case AuthErrorCode.userDisabled.rawValue:
                        throw AutheticationError.noSuchUser
                            case AuthErrorCode.wrongPassword.rawValue:
                                throw AutheticationError.wrongPassword
                            case AuthErrorCode.invalidEmail.rawValue:
                                throw AutheticationError.invalidEmail
                            case AuthErrorCode.userNotFound.rawValue:
                                throw AutheticationError.noSuchUser
                            case AuthErrorCode.networkError.rawValue:
                                throw AutheticationError.networkError
                            default:
                                print("Unrecognized error code: \(error.code) - \(error.localizedDescription)")
                                throw AutheticationError.unknownError
                            }
                   
                }
           
           
        }
    
    
   
}

struct LoginView: View {
    
   
    @State var viewModel: LoginViewModel = LoginViewModel()
    @Environment(MainViewModel.self) var mainViewModel
    @Binding var showSheet: Bool
  
    
    var body: some View {
        
        VStack{
            
            
            
            baner
            
            
            emailField
            
            
            passwordField
            
            VStack(alignment: .leading){
                
                NavigationLink {
                    Text("reset hasła")
                } label: {
                    Text("Nie pamiętasz hasła ?")
                        .underline(color: .blue)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.bottom,30)
                }

                
                
                
                HStack{
                    Text("Nie masz jeszcze konta ?")
                    
                    NavigationLink {
                        InputNameView(showSheet: $showSheet)
                    } label: {
                        Text("Załóż teraz!")
                            .underline(color: .blue)
                            .foregroundStyle(.blue)
                            .padding(.horizontal,20)
                    }

                
                }
                
            }
            .padding()
            .padding(.top,30)
            
            
            
            Spacer()
            
            
            
            
            
           
                ButtonView(title: "Zaloguj się", color: .yellow)
                .padding(.bottom,10)
                .alert("Błąd", isPresented: $viewModel.showError, presenting: viewModel.errorMessage) { errorMessage in
                    Button("OK", role: .cancel) {
                        viewModel.showError = false
                    }
                } message: { errorMessage in
                    Text(errorMessage)
                }


                .onTapGesture {
                    
                    Task {
                           await viewModel.login()
                           if let errorMessage = viewModel.errorMessage {
                               viewModel.showError = true
                           } else {
                               mainViewModel.showSignInView = false
                               showSheet = false
                               mainViewModel.selectTab(.homePage)
                               try await mainViewModel.loadCurrentUser()
                           }
                       }
                  
                    
                }
            
            
            
            
            
            
        }
        
    }
}

extension LoginView {
    var baner: some View {
        HStack(spacing: 10){
            
            Text("Produkty, nagrody, okazYEAH!")
                .font(.title)
                .bold()
                .padding(.horizontal)
            
            Rectangle()
                .frame(height: 50)
            
            
        }
        .padding(10)
        .padding(.top,50)
    }
    
    var emailField: some View {
        VStack(alignment: .leading){
            Text("E-mail")
                .font(.caption)
                .requiredField()
                .foregroundStyle(.gray)
                .padding(.horizontal)
            
            TextField("Wprowadź e-mail", text: $viewModel.email)
                .padding()
                .frame(height: 50)
                .textInputAutocapitalization(.never)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                    
                )
                .padding(.horizontal)
            
            
        }
    }
    
    var passwordField: some View {
        VStack(alignment: .leading){
            Text("Hasło")
                .font(.caption)
                .requiredField()
                .foregroundStyle(.gray)
                .padding(.horizontal)
            
            ZStack{
                SecureField("Wprowadź hasło", text: $viewModel.password)
                    .padding()
                    .frame(height: 50)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.asciiCapable)
                    .autocorrectionDisabled(true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                        
                    )
                    .padding(.horizontal)
                    .opacity(viewModel.hidePasswordFieldOpacity ?  1 : 0)
                
                
                TextField("Wprowadź hasło", text: $viewModel.password)
                    .padding()
                    .frame(height: 50)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.asciiCapable)
                    .autocorrectionDisabled(true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                        
                    )
                    .padding(.horizontal)
                    .opacity(viewModel.hidePasswordFieldOpacity ?  0 : 1)
                
                Button(action: {
                    viewModel.hidePasswordFieldOpacity.toggle()
                }, label: {
                    Image(systemName: viewModel.hidePasswordFieldOpacity ? "eye" : "eye.slash" )
                        .accentColor(.gray)
                })
                .frame(maxWidth: .infinity,alignment: .bottomTrailing)
                .padding(.trailing,20)
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView( showSheet: .constant(true))
            .environment(MainViewModel())
    }
    
}
