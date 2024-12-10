//
//  LoginView.swift
//  McDonald
//
//  Created by Agata Przykaza on 08/10/2024.
//

import SwiftUI

@Observable final class LoginViewModel{
    var email: String = ""
    var password: String = ""
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return }
        
        try await AuthManager.shared.signInUser(email: email, password: password)
    }
}

struct LoginView: View {
    
    @State var hidePasswordFieldOpacity: Bool = true
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
                        Text("zaloz konto")
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
                .onTapGesture {
                    Task{
                        do{
                            try await viewModel.signIn()
                            mainViewModel.showSignInView = false
                            showSheet = false
                            mainViewModel.selectTab(.homePage)
                        }
                        catch{
                            print("Error: \(error)")
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
                .foregroundStyle(.gray)
                .padding(.horizontal)
            
            TextField("Wprowadź e-mail", text: $viewModel.email)
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
    NavigationStack {
        LoginView( showSheet: .constant(true))
            .environment(MainViewModel())
    }
    
}
