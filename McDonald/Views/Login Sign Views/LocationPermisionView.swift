//
//  LocationPermisionView.swift
//  McDonald
//
//  Created by Agata Przykaza on 25/10/2024.
//

import SwiftUI

struct LocationPermisionView: View {
    
    var pageNumber: Int = 1
    
    var body: some View {
        
        VStack {
           
           
                Image(systemName: "mappin.and.ellipse.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .foregroundStyle(.accent)
                    .padding(.bottom,30)
            
            VStack(alignment: .leading){
                Text("Daj nam znać, gdzie jesteś:)")
                    .fontWeight(.heavy)
                    .font(.title)
                    .padding(.bottom)
                
                Text("Dzięki temu będziemy mogli pokazać Ci restauracje w okolicy i wyświetlić Ci oferty z Twojego lokalnego McDonald's")
                    .font(.subheadline)
            }
            .padding()
            
            Spacer()
            
            Text("\(pageNumber)/3")
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
    LocationPermisionView()
}
