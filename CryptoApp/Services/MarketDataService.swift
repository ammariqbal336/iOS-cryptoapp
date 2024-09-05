//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by mac on 31/08/2024.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData : MarketDataModel?
    
    var marketDataCancellable : AnyCancellable?
    
    init() {
        getData()
    }
    
     func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataCancellable = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] (returnData) in
                self?.marketData = returnData.data
                self?.marketDataCancellable?.cancel()
            }
        )

        
    }
}
