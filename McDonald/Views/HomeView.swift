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
                homeViewModel.showLoginCard.toggle()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
            }
            .padding(30)
        }
        
    }
    
    var mainPromo: some View{
        
        ZStack{
//            AsyncImage(url: ){ image in
//                image
//                    .resizable()
//                    .scaledToFit()
//                    .frame(minHeight: 300,maxHeight: 800)
//                    
//                
//            }placeholder: {
//                Rectangle()
//                    .foregroundStyle(.white)
//                    .frame(minHeight: 300,maxHeight: 700)
//                    .scaledToFill()
//                
//                    .overlay {
//                        ProgressView()
//                    }
           // }
        }
    }
    
}



#Preview {
    HomeView(selectionTab: .constant(Tabs.homePage))
}
