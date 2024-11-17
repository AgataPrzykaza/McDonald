//
//  OrderIntroView.swift
//  McDonald
//
//  Created by Agata Przykaza on 17/11/2024.
//

import SwiftUI

struct OrderIntroView: View {
    
    @Environment(OrderViewModel.self) var orderModel
    
    var body: some View {
        Spacer()
        
        VStack {
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
           
            orderModel.navigationPath.append(ViewState.map)
        } label: {
            ButtonView(title: "Wybierz restaurację", color: .yellow)
                .padding(.bottom, 10)
        }
    }
}

#Preview {
    OrderIntroView()
}
