//
//  PrizeCardView.swift
//  McDonald
//
//  Created by Agata Przykaza on 21/11/2024.
//


import SwiftUI




struct PrizeCardView: View {
    
    let prize: MPrize
    @State private var imageURL: URL?
    
    @Environment(MainViewModel.self) var mViewModel
    
    var body: some View {
        VStack{
            
            VStack{
                AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .frame(width: 150, height: 100)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .clipped()
                    } placeholder: {
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .clipped()
                            .overlay {
                                ProgressView()
                            }
                    }
                
                Text("\(prize.points) pkt")
                    .bold()
                    .foregroundStyle(.black)
                    .font(.system(size: 10))
                    .padding(5)
                    .background(.white, in: .capsule)
                    .padding(1)
                    .background(LinearGradient(gradient: Gradient(colors: [.red.mix(with: .black, by: 0.4), .yellow.mix(with: .red, by: 0.2)]), startPoint: .leading, endPoint: .trailing), in: .capsule)
                
            }
            .padding(.bottom,5)
            
            
            Text("Odbierz \(prize.title)")
                .font(.system(size: 10))
                .multilineTextAlignment(.center)
                .frame(height: 40)
                .padding(.horizontal,5)
                .foregroundStyle(.black)
            
            
            
            
        }
        .frame(width: 150, height: 200)
        .padding(5)
        .background(.white)
        .cornerRadius(8)
        .shadow(color:.gray, radius: 1, x: 0, y: 1)
        .padding(5)
        .task {
            await loadImage()
        }
        .opacity(mViewModel.user != nil ? 1 : 0.75)
        .overlay(alignment: .topLeading) {
            if mViewModel.user == nil {
                Image(systemName: "lock.fill")
                    .foregroundStyle(.gray)
                    .padding()
            }
        }
    }
    
    func loadImage() async {
        do {
            imageURL = try await FirestoreService().fetchImageURL(for: prize.imagePath)
        } catch {
            print("Error fetching image URL: \(error)")
        }
    }
}
