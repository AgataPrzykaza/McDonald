//
//  ViewModel.swift
//  McDonald
//
//  Created by Agata Przykaza on 04/10/2024.
//

import SwiftUI
import FirebaseStorage

@Observable
 class HomeViewViewModel{
   
      var showLoginCard: Bool = true
      var imageURLs: [URL] = []
      var selectedPromo: Promo?
      var promos: [Promo] = []
     
     func fetchImageURL(for imagePath: String) async throws -> URL {
         let storageRef = Storage.storage().reference(withPath: imagePath)
         let downloadURL = try await storageRef.downloadURL()
         return downloadURL
     }
     
}
