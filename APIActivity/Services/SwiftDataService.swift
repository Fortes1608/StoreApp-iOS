//
//  CharacterService.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import Foundation
import SwiftUI
import SwiftData

class SwiftDataService: SwiftDataServiceProtocol {
    
    internal var modelContainer: ModelContainer
    internal var modelContext: ModelContext
    
    @MainActor
    static var shared = SwiftDataService()
    
    @MainActor
    private init() {
        // Change isStoredInMemoryOnly to false if you would like to see the data persistance after kill/exit the app
        self.modelContainer = try! ModelContainer(for: Product.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchProducts() -> [Product] {
        do {
            // pra cada id puxar da api
            return try modelContext.fetch(FetchDescriptor<Product>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addProduct(_ product: Product) {
        modelContext.insert(product)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeProduct(_ product: Product) {
        modelContext.delete(product)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func setFavorite(_ product: Product) {
        
        addProduct(product)
        product.isFavorite = true
        
    }
    
    func setCart(_ product: Product) {
        
        var productExists: Bool = false
        
        for product in fetchProducts() where product == product {
            productExists = true
        }
        
        // se o produto nn existe ainda:
        if productExists == false {
            addProduct(product)
            product.isCart = true
        }
        // se o produto existe e está no cart:
        else if productExists && (product.isCart == true) {
            product.isCart = false
        }
        // se o produto existe e não está no cart:
        else if productExists && (product.isCart == false) {
            product.isCart = true
        }
        
    }
    
    func setOrdered(_ product: Product) {
        
        var productExists: Bool = false
        
        for product in fetchProducts() where product == product {
            productExists = true
        }
        
        // se o produto nn existe ainda:
        if productExists == false {
            addProduct(product)
            product.isOrdered = true
        }
        // se o produto existe e está no cart:
        else if productExists && (product.isOrdered == true) {
            product.isOrdered = false
        }
        // se o produto existe e não está no cart:
        else if productExists && (product.isOrdered == false) {
            product.isOrdered = true
        }
        
    }
    
}
