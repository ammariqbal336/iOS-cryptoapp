//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Muhammad Ammar on 29/08/2024.
//

import Foundation
import Combine
import SwiftUI
class CoinImageService {
    @Published var image :UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    init(coin: CoinModel) {
        self.coin  = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image ?? "") else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({(data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] (returnImage) in
                self?.image = returnImage
                self?.imageSubscription?.cancel()
            }
        )
    }
}
