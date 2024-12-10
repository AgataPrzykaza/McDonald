//
//  McDonaldApp.swift
//  McDonald
//
//  Created by Agata Przykaza on 01/10/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@Observable class MainViewModel{
    
    var showSignInView = false
    
     var selectedTab: Tabs = .homePage
    
    func selectTab(_ tab: Tabs){
        selectedTab = tab
    }
    
    func shoSignInToggle(){
        showSignInView.toggle()
    }
}

@main
struct McDonaldApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var viewModel: MainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(viewModel)
                
        }
    }
}
