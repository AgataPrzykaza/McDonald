//
//  FilterButton.swift
//  McDonald
//
//  Created by Agata Przykaza on 14/11/2024.
//

import SwiftUI

struct FilterButton:  View {
    
    var name: String
    
    var isSelected: Bool = false
    
    var body: some View {
        Text(name)
            .tint(.black)
            .font(.caption)
            .padding(8)
            .padding(.horizontal, 8)
            .background(isSelected ? .accent : .white, in: Capsule())
            .padding(1)
            .background(.gray, in: .capsule)

    }
}


