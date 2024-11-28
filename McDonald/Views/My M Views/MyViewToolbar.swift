//
//  ToolbarMyM.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import SwiftUI

struct MyViewToolbar: ToolbarContent{
    
    @Binding var points : Points

    
    var body: some ToolbarContent{
        ToolbarItem(placement: .topBarLeading) {
            Image("myMLogo")
                .resizable()
                .scaledToFill()
                .frame(width: 75)
                .clipShape(.capsule)
                .padding(2)
                .background(.red.opacity(0.6).gradient, in: .capsule)
               
                
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink(value: points) {
                
                HStack{
                    Text("\(points.currentPoints) pkt")
                        .fontWeight(.heavy)
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(.black)
                
            }
            
        }
    }
    
}


