//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by mac on 28/08/2024.
//

import Foundation
import Combine
class HomeViewModel : ObservableObject {
    
    @Published var stats: [StatisticsModel] = []
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private var coinDataService = CoinDataService()
    private var marketDataService = MarketDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
       addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoin)
            .sink { [weak self] (returnCoin) in
                self?.allCoins = returnCoin
            }
            .store(in: &cancellable)
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnStats) in
                self?.stats = returnStats
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
    
    private func mapGlobalMarketData(marketData: MarketDataModel?) -> [StatisticsModel] {
        var stats : [StatisticsModel] = []
        
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "24h Volume", value: data.volume)
        let btcDominance  = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio  = StatisticsModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        
        ])
        
        return stats
    }
 
}
