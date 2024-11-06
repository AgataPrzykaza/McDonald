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



struct HomeView: View {
    
    @Binding var selectionTab: Tabs
    @State var showLoginCard: Bool = true
    @State  var imageURLs: [URL] = []
    @State var selectedPromo: Promo?
    @State var promos: [Promo] = []
    
    func fetchImageURL(for imagePath: String) async throws -> URL {
        let storageRef = Storage.storage().reference(withPath: imagePath)
        let downloadURL = try await storageRef.downloadURL()
        return downloadURL
    }
    
    func whereToGo(promo: Promo) {
        
        
        
        if promo.type == "link"{
            
            switch promo.title {
            case "delivery":
                selectionTab = .mcdelivery
                
            case "okazyeah":
                selectionTab = .myM
                
            case "takeout":
                selectionTab = .order
                
            default:
                selectionTab = .homePage
            }
        }
        else{
            
            selectedPromo = promo
        }
        
        
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
                            .padding(.bottom,20)
                            .onTapGesture{
                                
                                    whereToGo(promo: promo)
                                
                               
                            }
                        
                        
                        
                        
                    }
                }
                
                
                
                
                
            }
            .navigationDestination(isPresented: Binding<Bool>(
                get: { selectedPromo != nil },
                set: { if !$0 { selectedPromo = nil } }
            ), destination: {
                if let promo = selectedPromo {
                    PromoView(promo: promo, selectionTab: $selectionTab)
                        
                }
                
            })
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
    HomeView(selectionTab: .constant(Tabs.homePage))
}
