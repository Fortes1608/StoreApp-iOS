//
//  UserViewModel.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 18/08/25.
//

import SwiftData
import Foundation

import Foundation
import SwiftUI
import SwiftData

class ProductDataViewModel: ObservableObject, ProductDataViewModelProtocol {
    
    @Published var products: [Product] = []
    @Published var favorites: [Product] = []
    @Published var cart: [Product] = []
    @Published var ordered: [Product] = []
    
    var dataSource: SwiftDataService
    
    init(service: SwiftDataService) {
        self.dataSource = service
        loadAllData()
    }
    
    func loadAllData() {
        DispatchQueue.main.async {
            self.products = self.dataSource.fetchProducts()
            self.favorites = self.dataSource.fetchFavorites()
            self.cart = self.dataSource.fetchCart()
            self.ordered = self.dataSource.fetchOrders()
        }
    }
    
    func refreshFavorites() {
        favorites = dataSource.fetchFavorites()
    }
    func refreshCart() {
        cart = dataSource.fetchCart()
    }
    func refreshOrdered() {
        ordered = dataSource.fetchOrders()
    }
    
    // MARK: - Actions
    func setFavorite(_ product: Product) {
        dataSource.setFavorite(product)
        // Aguardar um pouco antes de recarregar os dados para evitar problemas de estado
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.loadAllData()
        }
    }
    
    func setCart(_ product: Product) {
        dataSource.setCart(product)
        // Aguardar um pouco antes de recarregar os dados para evitar problemas de estado
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.loadAllData()
        }
    }
    
    func setOrdered(_ product: [Product]) {
        dataSource.setOrdered(product)
        loadAllData()
    }
    
    func totalPrice() -> Double {
        var totalPrice: Double = 0
        for product in cart {
            if product.quantity > 0 {
                totalPrice += Double(product.quantity) * product.priceAPI
            }
            else {
                totalPrice += 0
            }
        }
        return totalPrice
    }
    
    // MARK: - Sync
    private func reloadProducts() {
        products = dataSource.fetchProducts()
    }
}

