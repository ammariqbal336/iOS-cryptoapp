//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by mac on 24/08/2024.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .environmentObject(vm)
        //.environmentObject(vm)
    }
}
