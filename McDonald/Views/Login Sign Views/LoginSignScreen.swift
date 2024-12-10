//
//  StartScreen.swift
//  McDonald
//
//  Created by Agata Przykaza on 08/10/2024.
//

import SwiftUI

struct LoginSignScreen: View {
    

    @Environment(\.dismiss) var dismiss
    @Binding var showSheet: Bool
    
    var body: some View {
        
        VStack{
            
            HStack{
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .onTapGesture {
                        showSheet = false
                    }
                
                Spacer()
            }
            .padding(.horizontal)
            VStack(alignment: .leading){
                
                Rectangle()
                    .frame(height: 200)
                
                Text("Punkty, nagrody, okazYEAH!")
                    .font(.title)
                    .bold()
                
                Text("Masz już apkę Maka? Zaloguj się na swoje konto. Jeżeli nie masz konta, załóż je w kilku prostych krokach :)")
                    .font(.subheadline)
                    .padding(.top,8)
                
                Spacer()
                
                
                
            }
            .padding(20)
            
            
            ZStack{
                
                Color.yellow
                
               
                
                HStack(spacing: 0){
                    
                    NavigationLink {
                        LoginView( showSheet: $showSheet)
                    } label: {
                        Text("Zaloguj się")
                            .frame(maxWidth: .infinity)
                            .padding(20)
                            .background(Color.white )
                            .foregroundColor(.black)
                        
                    }
                    
                    NavigationLink {
                        RegisterView(showSheet: $showSheet)
                    } label: {
                        Text("Załóż konto")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.black)
                        
                    }
                    
                    
                }
                
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.black)
                    .padding(.bottom,60)
                
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.black)
                    .padding(.top,60)
                   
            }
            .frame(height: 50)
          
                
        }
    
        
        
    }
}

#Preview {
    NavigationStack {
        LoginSignScreen( showSheet: .constant(true))
            .environment(MainViewModel())
    }
 
}
