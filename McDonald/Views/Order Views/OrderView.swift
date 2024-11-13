//
//  OrderView.swift
//  McDonald
//
//  Created by Agata Przykaza on 07/10/2024.
//

import SwiftUI

struct OrderView: View {
    
    @State var showNextView: Bool = false
    
    var body: some View {
        NavigationStack{
            
            Spacer()
            
            VStack{
                
                Image("restaurant")
                    .resizable()
                    .frame(height: 150)
                
                Text("Zamów i odbierz")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                Text("Zamawiaj szybko i wygodnie w aplikacji i odbieraj w wybranej restauracji, tak jak lubisz - przy ladzie, do stolika, w McDrive, lub na parkingu.")
                    .multilineTextAlignment(.center)
                
                
                
            }
            .padding()
           
            
            Spacer()
            
            
            Button {
                showNextView = true
            } label: {
                ButtonView(title: "Wybierz restaurację", color: .yellow)
                    .padding(.bottom,10)
            }
            .navigationDestination(isPresented: $showNextView) {
                MapView()
            }

       
            
        }
        
       
       
    }
}

#Preview {
    OrderView()
}
