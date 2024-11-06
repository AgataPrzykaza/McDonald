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

struct PromoView: View {
    
    var promo: Promo
    @Binding var selectionTab: Tabs
    @State var details: PromoDetails?
    @State var images: [ImageData] = []
    @State var arrayDescription: [String] = []
    
  
    
    var body: some View {
        
        
        ScrollView{
            LazyVStack {
                
                
                
                
                if details != nil  && !images.isEmpty{
                    
                    Text(details!.header)
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    // first promo image
                    AsyncImageView(imageData: images[0])
                    
                   
                        Text("ZAMÓW PRZEZ APLIKACJĘ!")
                            .fontWeight(.heavy)
                            .foregroundStyle(.black)
                            .padding()
                            .background(.yellow,in: .capsule)
                            .onTapGesture {
                               
                                    selectionTab = .order
                               
                                
                            }
                         
                
                 if let description = arrayDescription.first {
                     
                     let (title, descript) = splitTitleAndDescription(from: description)
                     Text(title)
                         .multilineTextAlignment(.center)
                         .font(.title)
                         .fontWeight(.heavy)
                     
                     Text(descript)
                         .multilineTextAlignment(.center)
                         .fontWeight(.heavy)
                         .padding()
                    }
                   
                    ForEach(images.dropFirst().indices, id: \.self) { index in
                        
                        AsyncImageView(imageData: images[index])
                        if index < arrayDescription.count {
                            
                            let (title, descript) = splitTitleAndDescription(from: arrayDescription[index])
                            
                            Text(title)
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Text(descript)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            

                        }
                        
                    }
                  
      
                    

                }
                
            }
        }
        .navigationTitle(details?.fullTitle ?? "brak")
        .navigationBarTitleDisplayMode(.inline)
        .task {
           await fetchDetails()
            await loadImages()
            description()
           
            
        }
       
       
       
    }
    
    func splitTitleAndDescription(from text: String) -> (title: String, description: String) {
        
        if let separatorIndex = text.firstIndex(of: "|") {
            let title = String(text[..<separatorIndex])
            let description = String(text[text.index(after: separatorIndex)...])
            return (title, description)
        } else {
            
            return ("", text)
        }
    }
    
    func addEnter( part: String) -> String{
        var newPart = part
        if let index = newPart.firstIndex(of: "|") {
            newPart.replaceSubrange(index...index, with: "\n")
        }
        return newPart
    }
    
    func description()  {
       
        var description: String = details!.description
        arrayDescription = []
        while description.contains("/") {
            
            if let index = description.firstIndex(of: "/") {
                let part1 = String((description[..<index]))
              
                arrayDescription.append(part1)
                description.removeSubrange(...index)
            }
        }
        arrayDescription.append(description)
        
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

//#Preview {
//    PromoView(promo: Promo(title: "burgers", type: "promo", imagePath: "mainHeaders/burger.jpg",promoDetail: "8Zsx6RryrrnMBq4aW1zC"), selectionTab: .constant(Tabs))
//}
