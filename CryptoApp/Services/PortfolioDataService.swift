//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by mac on 01/09/2024.
//

import Foundation
import CoreData

class PortfolioDataService {
    @Published var savedEntities : [PortfolioEntity] = []
    
    private let container : NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getPortfolio()
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities \(error)")
        }
    }
    
    //Mark Public
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            
            if amount > 0 {
                    update(entity: entity, amount: amount)
            }
            else {
                removeCoin(entity: entity)
            }
            
        } else {
            add(coin: coin, amount: amount)
        }
        
    }
    
    //Mark Private
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        }catch let error {
            print("Error while saving data \(error.localizedDescription)")
        }
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func removeCoin(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
    
}
