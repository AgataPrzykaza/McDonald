//
//  AsyncImageView.swift
//  McDonald
//
//  Created by Agata Przykaza on 06/11/2024.
//

import SwiftUI

struct AsyncImageView: View {
    
    var imageData: ImageData
    
    var body: some View {
        AsyncImage(url: imageData.imageURL){ image in
            image
                .resizable()
                .scaledToFit()
                .frame(minHeight: 300,maxHeight: 800)
                
            
        }placeholder: {
            Rectangle()
                .foregroundStyle(.white)
                .frame(minHeight: 300,maxHeight: 700)
                .scaledToFill()
            
                .overlay {
                    ProgressView()
                }
        }
    }
}


