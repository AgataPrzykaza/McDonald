//
//  PromoSubView.swift
//  McDonald
//
//  Created by Agata Przykaza on 06/11/2024.
//

import SwiftUI

struct PromoSubView: View {

    var imagePath: String
    @State private var imageURL: URL?
    
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 50,height: 300)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
                
        } placeholder: {
            Rectangle()
                .foregroundStyle(.white)
                .frame(width: UIScreen.main.bounds.width - 50,height: 300)
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
                .overlay {
                    ProgressView()
                }
        }
        .task {
            await loadImage()
        }
    }
    
    func loadImage() async {
        do {
            imageURL = try await FirestoreService().fetchImageURL(for: imagePath)
        } catch {
            print("Error fetching image URL: \(error)")
        }
    }
    

}


