//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by mac on 28/08/2024.
//

import Foundation
import Combine
class HomeViewModel : ObservableObject {
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    private var dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
       addSubscribers()
        
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellable)
    }
}
