//
//  ContentView.swift
//  CryptoApp
//
//  Created by mac on 24/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Text("Hello, world!")
                .foregroundColor(Color.theme.accent)
            Text("Hello, world!")
                .foregroundColor(Color.theme.green)
            Text("Hello, world!")
                .foregroundColor(Color.theme.red)
            Text("Hello, world!")
                .foregroundColor(Color.theme.secondaryText)
            
        }
        .background(Color.theme.background)
        .padding()
    }
}

#Preview {
    ContentView()
}
