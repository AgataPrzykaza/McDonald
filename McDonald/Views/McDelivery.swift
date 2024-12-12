//
//  McDelivery.swift
//  McDonald
//
//  Created by Agata Przykaza on 07/10/2024.
//

import SwiftUI

struct McDelivery: View {
    @Environment(MainViewModel.self) var mViewModel
    
    var body: some View {
        VStack{
            List{
                if let user = mViewModel.user {
                    Text(user.email ?? "nie ma")
                }
              
            }
        }
    }
}

#Preview {
    McDelivery()
        .environment(MainViewModel())
}
