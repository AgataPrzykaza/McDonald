//
//  LoginView.swift
//  McDonald
//
//  Created by Agata Przykaza on 08/10/2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var hidePasswordFieldOpacity: Bool = true
    
    var body: some View {
        
        VStack{
            
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
            
            
            VStack(alignment: .leading){
                Text("E-mail")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                
                TextField("", text: .constant(""))
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                        
                    )
                    .padding(.horizontal)
                
                
            }
            
            
            VStack(alignment: .leading){
                Text("Hasło")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                
                ZStack{
                    SecureField("Enter Text", text:.constant(""))
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
                    
                    
                    TextField("", text: .constant(""))
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
            
            VStack(alignment: .leading){
                Text("Nie pamiętasz hasła ?")
                    .underline(color: .blue)
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.bottom,30)
                
                HStack{
                    Text("Nie masz jeszcze konta ?")
                    
                    Text("Załóż teraz!")
                        .underline(color: .blue)
                        .foregroundStyle(.blue)
                        .padding(.horizontal,20)
                }
                
            }
            .padding()
            .padding(.top,30)
            
            
            
            Spacer()
            
            
            
            
            
            NavigationLink {
                
            } label: {
                ButtonView(title: "Zaloguj się", color: .yellow)
            }
            .padding(.bottom,10)
            
            
            
            
            
            
        }
        
    }
}

#Preview {
    LoginView()
}
