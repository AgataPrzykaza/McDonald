//
//  MyMView.swift
//  McDonald
//
//  Created by Agata Przykaza on 07/10/2024.
//

import SwiftUI

@MainActor
@Observable class PointsViewModel{
    
    var points: Points?
    
    func getPoints(for userID: String) async{
        do{
            self.points = try await PointsManager.shared.getPoints(for: userID)
        }catch{
            print("Something wrong with fatching points")
        }
        
    }
    
}

struct MyMView: View {
    
    @Environment(MainViewModel.self) var mViewModel
    @State var vmodel: PointsViewModel = PointsViewModel()
    @State var myService: MyMService = MyMService()
    
    @State var showQRSheet: Bool = false
    
    let userID = "M23423434"
    
  
    
    var body: some View {
        
        
        NavigationStack{
            ScrollView{
                VStack{
                    
                    
                    if let user = mViewModel.user {
                        UserQRCodeView(userID: userID)
                            .background(content: {
                                Color.white
                                    .clipShape(.rect(cornerRadius: 15))
                                    .shadow(radius: 2)
                            })
                            .padding()
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    showQRSheet.toggle()
                                    
                                    
                                }
                                
                            }
                    }
                    else{
                        
                        VStack(alignment:.leading){
                            
                            Text("Witaj w MojeM!")
                                .fontWeight(.heavy )
                            
                            Text("Zbieraj punkty, odbieraj nagrody, łap okazYEAH!")
                                .font(.title)
                                .fontWeight(.heavy)
                            
                            Text("Zdobywaj punkty za zakupy i wymieniaj je na świetne nagrody. Korzystaj z okazYEAH!. Zamawiaj wygodnie w Zamów i Odbierz.")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .padding(.vertical)
                            
                            HStack{
                                
                                Button {
                                    
                                } label: {
                                    Text("Załóż konto")
                                        .foregroundStyle(.black)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(.yellow, in: .rect(cornerRadius: 5))
                                }
                                
                                Button {
                                    
                                } label: {
                                    Text("Dlaczego warto?")
                                        .foregroundStyle(.black)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(.gray.mix(with: .white, by: 0.5), in: .rect(cornerRadius: 5))
                                   
                                }
                                
                            }
                            .padding(.vertical)
                            .padding(.top,30)
                            
                            Divider()
                            
                        }.frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.vertical)
                        
                    }
                    
                       
                    
                    prizeHeaders
                        .padding(.bottom)
                    
                    couponsHeaders
                    
                    Spacer()
                }
                .sheet(isPresented: $showQRSheet) {
                    QRSheet(userID: userID)
                }
                
            }
            .padding(.horizontal)
            .navigationDestination(for: Points.self) { points in
                Text("Details for Points")
            }
            .onAppear{
                Task{
                    await myService.fetchPrizes()
                    await myService.fetchCoupons()
                    
                    guard let user = mViewModel.user else { return }
                    await vmodel.getPoints(for: user.userId)
                   
                }
            }
            .toolbar{
                
                MyMToolbar()
                
                if mViewModel.user != nil{
                    PointsToolbar(points: $vmodel.points)
                }
               
               
            }
            .toolbarBackground(.clear, for: .navigationBar)
            .scrollIndicators(.hidden)
            
        }
       
        
    }
}




#Preview {
    MyMView()
        .environment(MainViewModel())
}


