//
//  LogOutView.swift
//  McDonald
//
//  Created by Agata Przykaza on 05/12/2024.
//

import SwiftUI

@MainActor
@Observable
final class SettingsViewModel{
    
    func signOut() throws {
        try AuthManager.shared.signOut()
    }
}

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @Environment(MainViewModel.self) var mViewModel
   
    
    @State var isAuthenticated: Bool = false
    var body: some View {
        List{
            
            if isAuthenticated {
                Button("Wyloguj się"){
                    
                    Task{
                        do {
                            try viewModel.signOut()
                            await MainActor.run {
                                       mViewModel.showSignInView = true
                                       mViewModel.selectTab(.homePage)
                                mViewModel.user = nil
                                   }
                        } catch {
                            print(error)
                        }
                    }
                    
                }
            }
         
            
        }
        .onAppear{
            let authuser = try? AuthManager.shared.getAuthenticatedUser()
            isAuthenticated = authuser != nil
        }
        .navigationTitle("Ustawienia")
    }
}

#Preview {
    SettingsView( )
        .environment(MainViewModel())
}
