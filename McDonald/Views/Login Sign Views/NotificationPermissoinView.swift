//
//  NotificationPermissoinView.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/10/2024.
//

import SwiftUI

struct NotificationPermissoinView: View {
   
    
    
    var body: some View {
        
        VStack {
           
           
                Image(systemName: "bell.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .foregroundStyle(.accent)
                    .padding(.bottom,30)
            
            VStack(alignment: .leading){
                Text("Bądź zawsze       na bieżąco!")
                    .fontWeight(.heavy)
                    .font(.title)
                    .padding(.bottom)
                
                Text("Raz na jakiś czas będziemy wysyłać Ci powiadomienia push, by dać znać o nowych pysznych produktach,aktualnych promocjach i najlepszych ofertach.")
                    .font(.subheadline)
            }
            .padding()
            
            Spacer()
            
            Text("2/3")
                .fontWeight(.heavy)
            
            NavigationLink {
                
            } label: {
                ButtonView(title: "Kontynuuj", color: .yellow)
            }
            .padding(.bottom,10)
            
        }
    }
}

#Preview {
    NotificationPermissoinView()
}
