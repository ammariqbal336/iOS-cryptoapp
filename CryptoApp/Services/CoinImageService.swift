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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    
    init(coin: CoinModel) {
        self.coin  = coin
        self.imageName = coin.id ?? ""
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(fileName: imageName, folderName: folderName) {
            image = savedImage
            print("RetrieveImage")
        }
        else {
            downloadImage()
            print("DownloadImage")
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: coin.image ?? "") else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({(data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] (returnImage) in
                guard let self = self, let downloadedImage = returnImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: imageName, folderName: folderName)
            }
        )
    }
}
