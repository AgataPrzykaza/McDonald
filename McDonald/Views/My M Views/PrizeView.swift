//
//  PrizeView.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import SwiftUI

struct PrizeView: View {
    
    let prize: MPrize
    @State var imageURL: URL?
    
    @State var rules: [String] = ["Zaloguj się / Załóż konto"]
    
    var body: some View {
       
        VStack{
            ScrollView{
                VStack(){
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .frame(width: 350, height: 250)
                            .scaledToFit()
                        
                    } placeholder: {
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame( height: 250)
                            .scaledToFit()
                            .overlay {
                                ProgressView()
                            }
                    }
                    
                    VStack(alignment: .leading){
                        Text("Odbierz \(prize.title)")
                            .font(.title)
                            .bold()
                        
                        
                        Text("\(prize.points) pkt")
                            .bold()
                            .foregroundStyle(.black)
                            .font(.headline)
                            .bold()
                            .padding(5)
                            .padding(.horizontal,5)
                            .background(.white, in: .capsule)
                            .padding(1)
                            .background(LinearGradient(gradient: Gradient(colors: [.red.mix(with: .black, by: 0.4), .yellow.mix(with: .red, by: 0.2)]), startPoint: .leading, endPoint: .trailing), in: .capsule)
                        
                        Text("Zasady")
                            .bold()
                            .font(.headline)
                            .padding(.top)
                        
                        ForEach(rules,id: \.self){ rule in
                            Text(rule)
                                .font(.subheadline)
                            Divider()
                                .padding(.horizontal)
                            
                        }
                        .padding(.top,5)
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                    
                }
                .padding(5)
            }
            
           Text("Odbierz")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.yellow, in: .rect)
              
        }
        .task {
            await loadImage()
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


