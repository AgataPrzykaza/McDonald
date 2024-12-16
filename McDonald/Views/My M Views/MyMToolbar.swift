//
//  ToolbarMyM.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import SwiftUI

struct MyMToolbar: ToolbarContent{
    
   

   
    
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
        
      
    }
    
}

struct PointsToolbar: ToolbarContent{
    
    @Binding var points : Points?
    
    var body: some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            
            NavigationLink {
                PointsHistoryView(points: $points)
            } label: {
                HStack{
                    Text("\(points?.currentPoints ?? 12345) pkt")
                        .fontWeight(.heavy)
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(.black)
            }

           
            
        }
    }
}
