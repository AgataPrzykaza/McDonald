//
//  QRView.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


extension String {
    func generateQRCode() -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        let data = Data(self.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
}

struct UserQRCodeView: View {
    
    let userID: String
    
    func abbreviatedUserID(_ userID: String, visibleCount: Int = 4) -> String {
        guard userID.count > visibleCount * 2 else { return userID }
        let start = userID.prefix(visibleCount)
        let end = userID.suffix(visibleCount)
        return "\(start)...\(end)"
    }

   

    
    var body: some View {
        
        VStack{
            
           
                VStack{
                    if let qrImage = userID.generateQRCode() {
                        Image(uiImage: qrImage)
                            .resizable()
                            .interpolation(.none) 
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                        
                        
                        Text(abbreviatedUserID(userID))
                            .monospaced()
                            .font(.headline)
                            .fontWeight(.heavy)
                        
                    }
                }
                .padding(10)
                .background(.white,in: .rect(cornerRadius: 15))
            
            Text("Zeskanuj kod, aby zbierać punkty.")
                

        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.yellow, in: .rect(cornerRadius: 15))
        .overlay(alignment: .topTrailing) {
            
            Image(systemName:"info.circle")
                .resizable()
                .scaledToFit()
                .frame(height: 25)
                .tint(.black)
                .padding()
                
        }
        .padding(5)
       
       
      
            
    }
}

#Preview {
    UserQRCodeView(userID: "M224536")
       
}
