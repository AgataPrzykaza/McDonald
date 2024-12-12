//
//  RegisterView.swift
//  McDonald
//
//  Created by Agata Przykaza on 05/12/2024.
//

import SwiftUI
import Foundation
import FirebaseAuth

@MainActor
@Observable
final class SignInEmailViewModel{
    
    var email = ""
    var password = ""
    var errorMessage: String?
    var showError: Bool = false
    var hidePasswordFieldOpacity: Bool = true
    
    func signUp(name: String) async  {
        
        do {
            try validateInput()
            
           let result =  try await perfomRegister()
            
            let user = UserDB(auth: result, name: name)
            try await UserManager.shared.createNewUser(user: user)
            
            
        } catch {
            
            errorMessage = error.localizedDescription
        }
        
        
        
        
    }
    
    func perfomRegister() async throws
    -> AuthResultModel{
        do {
            let returnedUserData = try await  AuthManager.shared.createUser(with: email, password: password)
            return returnedUserData
            
        } catch let error as NSError {
            switch error.code {
            case AuthErrorCode.operationNotAllowed.rawValue:
                throw AutheticationError.noSuchUser
            case AuthErrorCode.invalidEmail.rawValue:
                throw AutheticationError.invalidEmail
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                throw AutheticationError.emailInUse
            case AuthErrorCode.networkError.rawValue:
                throw AutheticationError.networkError
            case AuthErrorCode.weakPassword.rawValue:
                throw AutheticationError.weakPassword
            default:
                print("Unrecognized error code: \(error.code) - \(error.localizedDescription)")
                throw AutheticationError.unknownError
            }
            
        }
    }
    
    
    
    private func validateInput() throws {
        guard email.contains("@") else { throw AutheticationError.invalidEmail }
        guard password.count >= 6 else { throw AutheticationError.invalidPassword }
        
        
    }
}

struct RegisterView: View {
   
    @Environment(MainViewModel.self) var mainViewModel
    
    @State private var viewModel = SignInEmailViewModel()
    @Binding var showSheet: Bool
    var name: String
    
    var body: some View {
        
        VStack{
            
            ScrollView{
                VStack(alignment: .leading){
                    Image("myMLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                    
                    
                    
                    VStack(alignment: .leading){
                        Text("Załóż konto")
                            .font(.title)
                            .bold()
                            .padding(.horizontal)
                            .padding(.bottom,40)
                        
                        Text("Wpisz dane, którymi chcesz się logować.")
                            .padding(.horizontal)
                            .padding(.bottom,30)
                        
                        emailField
                            .padding(.bottom,20)
                        
                        passwordField
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                
            }.scrollIndicators(.hidden)
            
            Spacer()
            
            ButtonView(title: "Załóż konto", color: .yellow)
                .alert("Błąd", isPresented: $viewModel.showError, presenting: viewModel.errorMessage) { errorMessage in
                    Button("OK", role: .cancel) {
                        viewModel.showError = false
                    }
                } message: { errorMessage in
                    Text(errorMessage)
                }
                .onTapGesture {
                    
                    Task {
                        await viewModel.signUp(name: name)
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
                .padding(.bottom,10)
            
        }
    }
}

extension RegisterView{
    
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
    RegisterView( showSheet: .constant(true), name: "Ala")
        .environment(MainViewModel())
}
