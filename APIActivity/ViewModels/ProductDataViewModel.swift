//
//  UserViewModel.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 18/08/25.
//

import Foundation
import SwiftUI
import SwiftData

class ProductDataViewModel: ObservableObject, ProductDataViewModelProtocol {
    
    @Published var products: [Product] = []
    @Published var favorites: [Product] = []
    @Published var cart: [Product] = []
    @Published var ordered: [Product] = []
    
    var dataSource: SwiftDataServiceProtocol
    
    init(service: SwiftDataServiceProtocol) {
        self.dataSource = service
        loadAllData()
    }
    
    func loadAllData() {
            products = dataSource.fetchProducts()
            favorites = dataSource.fetchFavorites()
            cart = dataSource.fetchCart()
            ordered = dataSource.fetchOrders()
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
        self.loadAllData()
    }
    
    func setCart(_ product: Product) {
        dataSource.setCart(product)
        self.loadAllData()
    }
    
    func setOrdered(_ product: [Product]) {
        // Validação de segurança
        guard !product.isEmpty else {
            print("Error: No products to order")
            return
        }
        
        dataSource.setOrdered(product)
        self.loadAllData()
        self.cart.removeAll()
        self.loadAllData()
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
}

