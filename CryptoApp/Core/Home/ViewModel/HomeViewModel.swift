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
    @Published var isLoading: Bool = false
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private var coinDataService = CoinDataService()
    private var marketDataService = MarketDataService()
    private var portfolioDataService = PortfolioDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
<<<<<<< HEAD
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
       
        //update all coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoins)
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellable)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnStats) in
                self?.stats = returnStats
                self?.isLoading = false
            }
            .store(in: &cancellable)
        
        
=======
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }        
>>>>>>> 2a783c7 (space)
    }
    
    private func mapAllCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
    
    private func mapGlobalMarketData(marketData: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticsModel] {
        var stats : [StatisticsModel] = []
        
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "24h Volume", value: data.volume)
        let btcDominance  = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = 
        portfolioCoins
            .map( {$0.currentHoldingsValue})
            .reduce(0, +)
        
        let previousValue =
        portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0.0) / 100
            let previousValue = currentValue / (1 + percentChange)
             return previousValue
        }
        .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio  = StatisticsModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimal(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        
        ])
        
        return stats
    }
 
}
