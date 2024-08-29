//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Muhammad Ammar on 29/08/2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin : CoinModel
    private let dataService: CoinImageService
    
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        dataService = CoinImageService(coin: coin)
        self.addSubscriber()
        self.isLoading = true
    }
    
    func addSubscriber(){
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading  = false
            } receiveValue: { [weak self] (returnImage) in
                self?.image = returnImage
            }
            .store(in: &cancellable)

    }
}
