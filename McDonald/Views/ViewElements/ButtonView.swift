//
//  ButtonView.swift
//  McDonald
//
//  Created by Agata Przykaza on 10/10/2024.
//

import SwiftUI

struct ButtonView: View {
    
    var title: String
    var color: Color
    
    
    var body: some View {
      
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(color)
                .foregroundStyle(.black)
                .overlay(content: {
                    Rectangle()
                        .stroke(lineWidth: 1)
                })
       
    }
}

#Preview {
    ButtonView(title: "Zaloguj się", color: Color.yellow)
}
