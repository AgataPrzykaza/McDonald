//
//  PromoView.swift
//  McDonald
//
//  Created by Agata Przykaza on 31/10/2024.
//

import SwiftUI

struct ImageData: Identifiable {
    let id = UUID()  
    let imagePath: String
    let imageURL: URL
}

struct PromoView: View {
    
    var promo: Promo
    @State var details: PromoDetails?
    @State var images: [ImageData] = []
    
    var body: some View {
        
        VStack {
            Text(promo.title)
            
            if details != nil {
                ForEach (images){ imageData in
                    AsyncImage(url: imageData.imageURL){ image in
                        image
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 50,height: 300)
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .clipped()
                    }placeholder: {
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
                    
                }
            }
        }
        .task {
           await fetchDetails()
            await loadImages()
        }
       
       
    }
    
    func loadImages() async {
        do {
            if let details {
                       for imagePath in details.additionalImages {
                           let imageURL = try await FirestoreService().fetchImageURL(for: imagePath)
                           let imageData = ImageData(imagePath: imagePath, imageURL: imageURL)
                           images.append(imageData)
                       }
                   }
           
        } catch {
            print("Error fetching image URL: \(error)")
        }
    }
    
    func fetchDetails() async {
            if let promoID = promo.promoDetail {
                details = await FirestoreService().fetchPromoDetailsFromFirestore(for: promoID)
            } else {
                print("Brak dostępnego identyfikatora promoDetail dla tej promocji")
            }
        }
}

#Preview {
    PromoView(promo: Promo(title: "burgers", type: "promo", imagePath: "mainHeaders/burger.jpg",promoDetail: "8Zsx6RryrrnMBq4aW1zC"))
}
