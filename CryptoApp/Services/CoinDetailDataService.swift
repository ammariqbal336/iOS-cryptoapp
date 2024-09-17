//
//  CoinDataDetailService.swift
//  CryptoApp
//
//  Created by mac on 17/09/2024.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetail : CoinDetailModel? = nil
    
    var coinDetailCancellable : AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetail()
    }
    
     func getCoinDetail() {
         guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailCancellable = NetworkManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] (returnedCoins) in
                self?.coinDetail = returnedCoins
                self?.coinDetailCancellable?.cancel()
            }
        )

        
    }
}
