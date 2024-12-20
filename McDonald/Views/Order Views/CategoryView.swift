//
//  CategoryView.swift
//  McDonald
//
//  Created by Agata Przykaza on 20/12/2024.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            Text("asa")
        }
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                }

            }
        }
    }
}

#Preview {
    CategoryView()
}
