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
        self.modelContainer = try! ModelContainer(
            for: Product.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true) // persistencia fora do app
        )
        self.modelContext = modelContainer.mainContext
    }
    
    // MARK: - Fetch
    func fetchProducts() -> [Product] {
        do {
            return try modelContext.fetch(FetchDescriptor<Product>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchFavorites() -> [Product] {
        do {
            let descriptor = FetchDescriptor<Product>(
                predicate: #Predicate { $0.isFavorite == true }
            )
            return try modelContext.fetch(descriptor)
        } catch {
            fatalError("Failed to fetch favorites: \(error.localizedDescription)")
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
        toggleFlag(for: product, keyPath: \.isFavorite)
    }
    
    func setCart(_ product: Product) {
        toggleFlag(for: product, keyPath: \.isCart)
    }
    
    func setOrdered(_ product: Product) {
        toggleFlag(for: product, keyPath: \.isOrdered)
    }
    
    // MARK: - Helpers
    private func toggleFlag(for product: Product, keyPath: ReferenceWritableKeyPath<Product, Bool>) {
        if let existing = fetchProducts().first(where: { $0.idAPI == product.idAPI }) {
            existing[keyPath: keyPath].toggle()
        } else {
            product[keyPath: keyPath] = true
            addProduct(product)
        }
        saveContext()
    }
    
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to save context: \(error.localizedDescription)")
        }
    }
}
