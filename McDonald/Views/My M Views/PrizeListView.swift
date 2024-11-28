//
//  PrizeListView.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import SwiftUI

struct PrizeListView: View {
    
    var prizes: [MPrize]
    
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        ScrollView{
            VStack{
                
                Text("Odbierz za punkty")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyHGrid(rows: rows,spacing: 10) {
                    ForEach(prizes, id: \.self){ prize in
                        
                        NavigationLink {
                            PrizeView(prize: prize)
                        } label: {
                            PrizeCardView(prize: prize)
                        }

                            
                        
                    
                        
                    }
                }
                
                
                
                
            }
           
            .padding()
        }
    
    }
}


