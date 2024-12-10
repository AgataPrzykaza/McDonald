//
//  RegisterView.swift
//  McDonald
//
//  Created by Agata Przykaza on 05/12/2024.
//

import SwiftUI
import Foundation

@MainActor
@Observable
final class SignInEmailViewModel{
    
    var email = ""
    var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else { return }
        
        let returnedUserData = try await  AuthManager.shared.createUser(with: email, password: password)
        
        
        
    }
    
}

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(MainViewModel.self) var mainViewModel
    
    @State private var viewModel = SignInEmailViewModel()
    
    @State var hidePasswordFieldOpacity: Bool = true
    @Binding var showSheet: Bool
    
    
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
                .onTapGesture {
                    Task{
                        do{
                            try await viewModel.signUp()
                           
                                mainViewModel.showSignInView = false
                                showSheet = false
                                mainViewModel.selectTab(.homePage)
                            
                        }
                        catch{
                            
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
                .foregroundStyle(.gray)
                .padding(.horizontal)
            
            TextField("Wprowadź e-mail", text: $viewModel.email)
                .padding()
                .frame(height: 50)
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
                    .opacity(hidePasswordFieldOpacity ?  1 : 0)
                
                
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
                    .opacity(hidePasswordFieldOpacity ?  0 : 1)
                
                Button(action: {
                    hidePasswordFieldOpacity.toggle()
                }, label: {
                    Image(systemName: hidePasswordFieldOpacity ? "eye" : "eye.slash" )
                        .accentColor(.gray)
                })
                .frame(maxWidth: .infinity,alignment: .bottomTrailing)
                .padding(.trailing,20)
                
            }
        }
    }
}
#Preview {
    RegisterView( showSheet: .constant(true))
        .environment(MainViewModel())
}
