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
    
    func updateProductQuantity(productId: Int, newQuantity: Int) {
        if let existing = fetchProducts().first(where: { $0.idAPI == productId }) {
            existing.quantity = max(0, newQuantity) // Garantir que quantidade não seja negativa
            if existing.quantity == 0 {
                existing.isCart = false // Remover do carrinho se quantidade for 0
            }
            saveContext()
            print("Product \(productId) quantity updated to: \(existing.quantity)")
        }
    }
    
    func setCart(_ product: Product) {
        // Verificar se o produto já existe no banco
        if let existing = fetchProducts().first(where: { $0.idAPI == product.idAPI }) {
            // Se o produto já existe, verificar seu estado atual
            if existing.isCart {
                // Se já está no carrinho, apenas incrementar quantidade
                existing.quantity += 1
                print("Product already in cart, quantity increased to: \(existing.quantity)")
            } else if existing.isOrdered {
                // Se está em orders, criar uma nova instância para o carrinho
                let newProduct = Product(from: existing)
                newProduct.isCart = true
                newProduct.isOrdered = false
                newProduct.quantity = 1
                addProduct(newProduct)
                print("Product moved from orders to cart")
            } else {
                // Se não está no carrinho nem em orders, adicionar ao carrinho
                existing.isCart = true
                existing.quantity = 1
                print("Product added to cart")
            }
        } else {
            // Se o produto não existe, criar com isCart = true
            let newProduct = Product(from: product)
            newProduct.isCart = true
            newProduct.quantity = 1
            addProduct(newProduct)
            print("New product added to cart")
        }
        saveContext()
    }
    
    func setOrdered(_ product: [Product]) {
        for p in product {
            if let existing = fetchProducts().first(where: { $0.idAPI == p.idAPI }) {
                existing.isOrdered = true
                existing.isCart = false // Remove do carrinho quando for para pedidos
                existing.quantity = 1 // Reset quantidade para 1
            } else {
                p.isOrdered = true
                p.isCart = false
                p.quantity = 1 // Garantir que quantidade seja 1
                addProduct(p)
            }
        }
        saveContext()
        // Limpar produtos órfãos após operações de checkout
        cleanupOrphanedProducts()
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
            } catch {
                print("Failed to rollback context: \(error.localizedDescription)")
            }
        }
    }
    
    // Função para limpar produtos órfãos (que não estão em nenhum estado válido)
    func cleanupOrphanedProducts() {
        let allProducts = fetchProducts()
        for product in allProducts {
            // Se o produto não está em nenhum estado válido, removê-lo
            if !product.isFavorite && !product.isCart && !product.isOrdered {
                removeProduct(product)
            }
        }
        saveContext()
    }
}
