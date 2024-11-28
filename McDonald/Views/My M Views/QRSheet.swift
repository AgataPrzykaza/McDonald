//
//  QRSheet.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import SwiftUI

struct QRSheet: View {
    
    let userID: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            
            HStack{
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            dismiss()
                        }
                      
                    }
                  
                Text("Zeskanuj kod, aby zbierać punkty")
                    .font(.headline)
                    .bold()
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.top)
        
            
            ScrollView{
                VStack(alignment: .leading){
                    
                    VStack{
                        if let qrImage = userID.generateQRCode() {
                            Image(uiImage: qrImage)
                                .resizable()
                                .interpolation(.none) // Zapewnia lepszą jakość obrazu
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            
                            
                            Text(userID)
                                .monospaced()
                                .font(.headline)
                                .fontWeight(.heavy)
                            
                        }
                    }
                    .padding(10)
                    .background(.white,in: .rect(cornerRadius: 15))
                    .frame(maxWidth: .infinity)
                    .padding(30)
                    .background(.yellow)
                    
                    
                    Text("Zeskanuj powyższy kod na kiosku w McDrive lub przy ladzie a my zrobimy resztę:) Pamiętaj tylko, że punkty mogą pojawić się na Twoim koncie do 7 dni o zakupu.")
                        .padding()
                    
                    NavigationLink {
                        Text("Problem ze skanowaniem")
                    } label: {
                        Text("Problem ze skanowaniem?")
                            .underline()
                            .foregroundStyle(.blue)
                            .padding(.horizontal)
                    }

                  
                    
                }
               
            }
        }
    }
}

#Preview {
    QRSheet(userID: "23123o3")
}
