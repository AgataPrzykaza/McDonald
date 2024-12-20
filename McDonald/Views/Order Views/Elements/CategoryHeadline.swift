//
//  CategoryHeadline.swift
//  McDonald
//
//  Created by Agata Przykaza on 20/12/2024.
//


import SwiftUI

struct CategoryHeadline: View {
    
    let category: Category
    @State private var imageURL: URL?
    
    func loadImage() async {
        do {
            imageURL = try await FirestoreService().fetchImageURL(for: category.imagePath)
        } catch {
            print("Error fetching image URL: \(error)")
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .frame(width: 60, height: 60)
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                            .clipped()
                    } placeholder: {
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 60)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                            .clipped()
                            .overlay {
                                ProgressView()
                            }
                    }
              
                
                Text(category.name)
                    .font(.title)
                    .bold()
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .imageScale(.large)
                
            }
            .padding()
            .foregroundStyle(.black)
            
            Divider()
        }
        .task {
            await loadImage()
        }
    }
}
