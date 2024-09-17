//
//  CoinDetailViewModel.swift
//  CryptoApp
//
//  Created by mac on 17/09/2024.
//

import Foundation
import Combine

class CoinDetailViewModel : ObservableObject {
    
    let coinDetailService: CoinDetailDataService
    var cancellables = Set<AnyCancellable>()
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscriber()
    }
    
    private func addSubscriber() {
        coinDetailService.$coinDetail
            .sink { coinDetails in
                print("Data Fetch Successfully")
                print(coinDetails)
            }
            .store(in: &cancellables)
    }
}
