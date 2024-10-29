//
//  HomeView.swift
//  McDonald
//
//  Created by Agata Przykaza on 07/10/2024.
//

import SwiftUI
import FirebaseStorage

struct PromoSubView: View {
    
    var imagePath: String
    @State private var imageURL: URL?
    
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Rectangle()
                .foregroundStyle(.white)
                .overlay {
                    ProgressView()
                }
        }
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(height: 320)
        .padding()
        .task {
            await loadImage()
        }
    }
    
    func loadImage() async {
        do {
            imageURL = try await fetchImageURL(for: imagePath)
        } catch {
            print("Error fetching image URL: \(error)")
        }
    }
    
    private func fetchImageURL(for imagePath: String) async throws -> URL {
        let storageRef = Storage.storage().reference(withPath: imagePath)
        let downloadURL = try await storageRef.downloadURL()
        return downloadURL
    }
    }
    //struct PromoSubView: View {
    //
    //    var imageURL: URL?
    //
    //
    //
    //
    //
    //    var body: some View {
    //
    //
    //        AsyncImage(url: imageURL) { image in
    //            image
    //                .resizable()
    //                .scaledToFill()
    //
    //        } placeholder: {
    //            Rectangle()
    //                .foregroundStyle(.white)
    //                .overlay {
    //                    ProgressView()
    //                }
    //
    //        }
    //        .clipped()
    //        .clipShape(RoundedRectangle(cornerRadius: 10))
    //        .frame(height: 320)
    //        .padding()
    //
    //    }
    //}
    
    
    struct HomeView: View {
        
        @State var showLoginCard: Bool = true
        @State  var imageURLs: [URL] = []
        
        @State var promos: [Promo] = []
        
        func fetchImageURL(for imagePath: String) async throws -> URL {
            let storageRef = Storage.storage().reference(withPath: imagePath)
            let downloadURL = try await storageRef.downloadURL()
            return downloadURL
        }
        
        var body: some View {
            
            NavigationStack{
                
                
                
                ScrollView{
                    
                    if showLoginCard == true{
                        loginCard
                    }
                    
                    
                    LazyVStack {
                        ForEach(promos, id: \.self) { promo in
                            PromoSubView(imagePath: promo.imagePath)
                                .shadow(color: .gray,radius: 4,y: 5)
                        }
                    }
                    
                    
                    
                    
                    
                }
                .onAppear{
                    Task {
                        imageURLs = await FirestoreService().fetchImagesFromFirebaseStorage()
                        promos = await FirestoreService().fetchMainPromosFromFirestore()
                        
                       
                    }
                    
                    
                }
                
                
            }
        }
        
        
        
        
        
    }
    
    extension HomeView{
        
        
        
        var loginCard: some View{
            
            ZStack{
                Rectangle()
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(height: 250)
                    .shadow(color: .gray,radius: 4,y: 5)
                    .padding()
                
                
                
                
                
                HStack{
                    VStack(alignment:.leading){
                        Text("Hej! Chyba nie jesteś zalogowany.")
                            .fontWeight(.heavy)
                            .font(.title2)
                        Text("Najlepsze znajdziesz po zalogowaniu ☺️")
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        
                        
                        Text("Zaloguj się")
                            .foregroundStyle(.black)
                            .frame(width: 150,height: 40)
                            .background(.yellow,in: .rect(cornerRadius: 5))
                        
                        
                        
                    }
                    .padding()
                    
                    VStack{
                        
                        
                        Rectangle()
                            .frame(height: 120)
                            .padding()
                        
                        
                    }
                    
                }
                .padding()
                
                
                
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    showLoginCard.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
                .padding(30)
            }
            
        }
        
    }
    
    
    
    #Preview {
        HomeView()
    }
