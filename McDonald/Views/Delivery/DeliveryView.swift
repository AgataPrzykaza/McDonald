//
//  DeliveryView.swift
//  McDonald
//
//  Created by Agata Przykaza on 23/12/2024.
//

import SwiftUI

struct DeliveryView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                
                VStack{
                    
                    HStack(spacing: 25){
                        
                        DeliveryImageView(app: .uberEats)
                        DeliveryImageView(app: .pyszne)
                        DeliveryImageView(app: .glovo)
                        DeliveryImageView(app: .wolt)
                        
                        
                    }
                    
                    Text("Znajdziesz najlepszy dostawę w Twoim regionie")
                        .font(.headline)
                        .bold()
                        .padding(.top,30)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    
                }
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        Text("Zamów z dostawą")
                            .bold()
                            .font(.title2)
                    }
                }
            }
        }
    }
}

#Preview {
    DeliveryView()
}
enum DeliveryApp: String {
    case uberEats = "uber"
    case wolt = "wolt"
    case glovo = "glovo"
    case pyszne = "pyszne"

    var appURL: String {
        switch self {
        case .uberEats:
            return "https://www.ubereats.com"
        case .wolt:
            return "https://wolt.com"
        case .glovo:
            return "https://glovoapp.com"
        case .pyszne:
            return "https://www.pyszne.pl"
        }
    }

    var appStoreURL: String {
        switch self {
        case .uberEats:
            return "https://apps.apple.com/app/id1058959277"
        case .wolt:
            return "https://apps.apple.com/app/id123456789"
        case .glovo:
            return "https://apps.apple.com/app/id123456789"
        case .pyszne:
            return "https://apps.apple.com/app/id457828116"
        }
    }
}


struct DeliveryImageView: View {
    
    let app: DeliveryApp
    
    func openApp(_ app: DeliveryApp) {
            guard let appURL = URL(string: app.appURL),
                  let appStoreURL = URL(string: app.appStoreURL) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
            }
        }
    
    var body: some View {
       
        
        Button {
            openApp(app)

        } label: {
            Image(app.rawValue)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(.rect(cornerRadius: 10))
        }

    }
}
