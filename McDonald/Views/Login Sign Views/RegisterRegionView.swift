//
//  RegisterRegionView.swift
//  McDonald
//
//  Created by Agata Przykaza on 10/10/2024.
//

import SwiftUI



struct RegisterRegionView: View {

   
    var body: some View {
        
        VStack {
            Image("worldIcon")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
            
            VStack(alignment: .leading) {
                Text("Select your region")
                    .font(.title)
                    .bold()
                    .fontWeight(.heavy)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
              
            }
            .padding(.horizontal)
            
            
            NavigationLink {
                Text("Wybor kraju")
            } label: {
                HStack{
                    Text("🇵🇱")
                        .font(.largeTitle)
                        .padding(.trailing)
                        
                    
                    
                    VStack{
                        Text("Polska")
                            .bold()
                        Text("Poland")
                       
                    }
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.title)
                }
                .font(.title2)
                .foregroundStyle(.black)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.black)
                }
                
                               
            }
            .padding()

            
            
            Text("Language")
                .bold()
            
        }
        
        
       
        
    }
}

#Preview {
    NavigationStack{
        RegisterRegionView()
    }
    
}
