//
//  PromoViewModel.swift
//  McDonald
//
//  Created by Agata Przykaza on 06/11/2024.
//

import SwiftUI

@Observable
class PromoViewModel {
    var details: PromoDetails?
    var images: [ImageData] = []
    var arrayDescription: [String] = []
    
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
    
  
}
