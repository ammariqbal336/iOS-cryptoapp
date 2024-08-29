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
    
    @Published var searchText: String = ""
    
    private var dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
       addSubscribers()
    }
    
    func addSubscribers() {
//        dataService.$allCoins
//            .sink { [weak self] coins in
//                self?.allCoins = coins
//            }
//            .store(in: &cancellable)
//        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoin)
            .sink { [weak self] (returnCoin) in
                self?.allCoins = returnCoin
            }
            .store(in: &cancellable)
    }
    
    private func filterCoin(text: String,coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowerCase = text.lowercased()
        
        return coins.filter { coin in
            return coin.name!.lowercased().contains(lowerCase) ||
            coin.symbol!.lowercased().contains(lowerCase) ||
            coin.id!.lowercased().contains(lowerCase)
        }
    }
    
}
