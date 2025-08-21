//
//  CharacterService.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import Foundation
import SwiftUI
import SwiftData

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
        do {
            self.modelContainer = try ModelContainer(
                for: Product.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            self.modelContext = modelContainer.mainContext
        } catch {
            fatalError("Failed to create ModelContainer: \(error.localizedDescription)")
        }
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
        modelContext.insert(product)
        saveContext()
    }
    
    func removeProduct(_ product: Product) {
        modelContext.delete(product)
        saveContext()
    }
    
    // MARK: - Toggles
    func setFavorite(_ product: Product) {
        // Verificar se o produto já existe
        if let existing = fetchProducts().first(where: { $0.idAPI == product.idAPI }) {
            // Se já existe, apenas toggle o flag de favorito
            existing.isFavorite.toggle()
        } else {
            // Se não existe, criar com isFavorite = true
            product.isFavorite = true
            addProduct(product)
        }
        saveContext()
    }
    
    func setCart(_ product: Product) {
        // Verificar se o produto já está no carrinho
        if let existing = fetchProducts().first(where: { $0.idAPI == product.idAPI }) {
            if existing.isCart {
                // Se já está no carrinho, apenas incrementar quantidade
                existing.quantity += 1
            } else {
                // Se não está no carrinho, adicionar
                existing.isCart = true
                existing.quantity = 1
            }
        } else {
            // Se o produto não existe, criar com isCart = true
            product.isCart = true
            product.quantity = 1
            addProduct(product)
        }
        saveContext()
    }
    
    func setOrdered(_ product: [Product]) {
        for p in product {
            if let existing = fetchProducts().first(where: { $0.idAPI == p.idAPI }) {
                existing.isOrdered = true
                existing.isCart = false // Remove do carrinho quando for para pedidos
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
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
            // Tentar fazer rollback se possível
            modelContext.rollback()
        }
    }
}
