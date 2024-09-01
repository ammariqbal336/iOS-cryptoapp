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
    
}
