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
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .environmentObject(vm)
    }
}
