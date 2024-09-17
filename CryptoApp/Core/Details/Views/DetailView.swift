//
//  DetailView.swift
//  CryptoApp
//
//  Created by mac on 07/09/2024.
//

import SwiftUI

struct DetailLoadingView : View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        if let coin = coin {
            DetailView(coin: coin)
        }
        
    }
}

struct DetailView: View {
    
    @StateObject var vm : CoinDetailViewModel
    
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
        print("Initialize coin view \(coin.name)")
    }
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
