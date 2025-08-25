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
    init() {
        self.modelContainer = try! ModelContainer(
            for: Product.self
        )
        self.modelContext = modelContainer.mainContext
    }
    
    private func fetchProduct(by idAPI: Int) -> Product? {
            let descriptor = FetchDescriptor<Product>(
                predicate: #Predicate { $0.idAPI == idAPI }
            )
            return try? modelContext.fetch(descriptor).first
        }
    
    // MARK: - Fetch
     func fetchProducts() -> [Product] {
        do {
            return try modelContext.fetch(FetchDescriptor<Product>())
        } catch {
            print("Error fetching products: \(error.localizedDescription)")
            return []
        }
    }
    
     func fetchFavorites() -> [Product] {
        do {
            let descriptor = FetchDescriptor<Product>(
                predicate: #Predicate { $0.isFavorite == true }
            )
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching favorites: \(error.localizedDescription)")
            return []
        }
    }
    
     func fetchCart() -> [Product] {
        do {
            let descriptor = FetchDescriptor<Product>(
                predicate: #Predicate { $0.isCart == true }
            )
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching cart: \(error.localizedDescription)")
            return []
        }
    }
    
     func fetchOrders() -> [Product] {
        do {
            let descriptor = FetchDescriptor<Product>(
                predicate: #Predicate { $0.isOrdered == true }
            )
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching orders: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Insert & Remove
     func addProduct(_ product: Product) {
        guard !fetchProducts().contains(where: { $0.idAPI == product.idAPI }) else { return }
        modelContext.insert(product)
        saveContext()
    }
    
     func removeProduct(_ product: Product) {
        guard fetchProducts().contains(where: { $0.idAPI == product.idAPI }) else { return }
        modelContext.delete(product)
        saveContext()
    }
    
    // MARK: - Toggles
     func setFavorite(_ product: Product) {
        
        if let existing = fetchProducts().first(where: { $0.idAPI == product.idAPI }) {
            
            existing.isFavorite.toggle()
        } else {
            let newProduct = product
            product.isFavorite = true
            addProduct(newProduct)
        }
        saveContext()
    }
    
     func updateProductQuantity(productId: Int, newQuantity: Int) {
        if let existing = fetchProducts().first(where: { $0.idAPI == productId }) {
            existing.quantity = max(0, newQuantity) 
            if existing.quantity == 0 {
                existing.isCart = false
            }
            saveContext()
            print("Product \(productId) quantity updated to: \(existing.quantity)")
        }
    }
    
    func setCart(_ product: Product) {
            DispatchQueue.main.async {
                if let existing = self.fetchProduct(by: product.idAPI) {
                    if existing.isCart {
                        existing.quantity += 1
                        print("Product already in cart, quantity increased to: \(existing.quantity)")
                    } else {
                        existing.isCart = true
                        existing.quantity = 1
                        print("Product added to cart")
                    }
                } else {
                    let newProduct = product
                    newProduct.isCart = true
                    newProduct.quantity = 1
                    self.addProduct(newProduct)
                    print("New product added to cart")
                }
                self.saveContext()
            }
        }
    
     func setOrdered(_ product: [Product]) {
        for p in product {
            if let existing = fetchProducts().first(where: { $0.idAPI == p.idAPI }) {
                existing.isOrdered = true
                existing.isCart = false
            } else {
                p.isOrdered = true
                p.isCart = false
                addProduct(p)
            }
        }
        saveContext()
    }
    
    // MARK: - Helpers
    private func saveContext() {
        do {
            try modelContext.save()
            print("Context saved successfully")
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
            // Tentar fazer rollback se possível
            do {
                modelContext.rollback()
                print("Context rolled back successfully")
            }
        }
    }
    
    // Função para limpar produtos órfãos (que não estão em nenhum estado válido)
//    func cleanupOrphanedProducts() {
//        let allProducts = fetchProducts()
//        for product in allProducts {
//            // Se o produto não está em nenhum estado válido, removê-lo
//            if !product.isFavorite && !product.isCart && !product.isOrdered {
//                removeProduct(product)
//            }
//        }
//        saveContext()
//    }
}
