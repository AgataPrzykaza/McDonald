//
//  HomeView.swift
//  McDonald
//
//  Created by Agata Przykaza on 07/10/2024.
//

import SwiftUI


struct PromoSubView: View {
    
    var promoTitle: String
    var promoDescription: String
    var imageURL: URL?
    
    var body: some View {
      
            
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .scaledToFill()
               
        } placeholder: {
            Rectangle()
                .foregroundStyle(.white)
                
        }
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(height: 320)
        .padding()

    }
}


struct HomeView: View {
    
    @State  var imageURLs: [URL] = []
    var body: some View {
        
        NavigationStack{
            
            ScrollView{
                
                PromoSubView(promoTitle: "HUmburger", promoDescription: "2x burger, fries",imageURL: imageURLs.first )
                    .shadow(color: .gray,radius: 5)
                
                 
                
                
                
            }
            .onAppear{
                Task {
                    imageURLs = await FirestoreService().fetchImagesFromFirebaseStorage()
                }
            }
            
            
        }
    }
    
    
    
    
    
}




#Preview {
    HomeView()
}
