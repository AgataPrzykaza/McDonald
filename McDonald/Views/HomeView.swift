//
//  HomeView.swift
//  McDonald
//
//  Created by Agata Przykaza on 07/10/2024.
//

import SwiftUI
import FirebaseStorage


struct HomeView: View {
    
    @Binding var selectionTab: Tabs
    @State var homeViewModel: HomeViewViewModel = .init()
    
 
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
            
            homeViewModel.selectedPromo = promo
        }
        
        
    }
    
    var body: some View {
        
        NavigationStack{
            
            
            
            ScrollView{
                
                mainPromo
                
                if homeViewModel.showLoginCard == true{
                    loginCard
                }
                
                
                LazyVStack {
                    ForEach(homeViewModel.promos, id: \.self) { promo in
                        
                        
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
                get: { homeViewModel.selectedPromo != nil },
                set: { if !$0 { homeViewModel.selectedPromo = nil } }
            ), destination: {
                if let promo = homeViewModel.selectedPromo {
                    PromoView(promo: promo, selectionTab: $selectionTab)
                        
                }
                
            })
            .onAppear{
                Task {
                    homeViewModel.imageURLs = await FirestoreService().fetchImagesFromFirebaseStorage()
                    homeViewModel.promos = await FirestoreService().fetchMainPromosFromFirestore()
                    homeViewModel.mainPromo = await FirestoreService().fetchMainPromo()
                    
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
                    
                    
                    Image(systemName: "key.fill")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 60))
                        .frame(height: 120)
                        .foregroundStyle(.accent.mix(with: .brown, by: 0.1))
                        .padding(.trailing,30)
                    
                    
                }
                
            }
            .padding()
            
            
            
        }
        .overlay(alignment: .topTrailing) {
            Button {
                homeViewModel.showLoginCard.toggle()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
            }
            .padding(30)
        }
        
    }
    
    var mainPromo: some View{
        
        ZStack(alignment: .bottomTrailing){
            
            if let imagePath = homeViewModel.mainPromo?.imagePath{
                
                AsyncImage(url: homeViewModel.mainImageURL) { image in
                    image
                        .resizable()
                        .frame(height: 350)
                        .scaledToFit()
                    
                    
                } placeholder: {
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 350)
                        .overlay {
                            ProgressView()
                        }
                }
                .task {
                    do {
                        homeViewModel.mainImageURL = try await FirestoreService().fetchImageURL(for: imagePath)
                    }catch{
                        print("Error fetching main promo Image: \(error.localizedDescription)")
                    }
                }
                
            }
            
            ZStack{
                
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 35)
                    .foregroundStyle(.gray.mix(with: .white, by: 0.8))
                
                Image(systemName: "arrow.right")
                    .foregroundStyle(.gray)
                
                
            }
            .padding()
            
            
            
            
        }
        .frame(height: 350)
        .onTapGesture {
            if let promo = homeViewModel.mainPromo{
                whereToGo(promo: promo)
            }
            
        }
    }
    
}



#Preview {
    HomeView(selectionTab: .constant(Tabs.homePage))
}
