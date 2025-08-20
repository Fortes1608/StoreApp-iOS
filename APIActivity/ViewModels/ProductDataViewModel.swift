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
        products = dataSource.fetchProducts()
        favorites = dataSource.fetchFavorites()
        //cart = dataSource.fetchCart()
        //ordered = dataSource.fetchOrders()
    }
    
    func refreshFavorites() {
        favorites = dataSource.fetchFavorites()
    }
    func refreshCart() {
        //cart = dataSource.fetchCart()
    }
    func refreshOrdered() {
        //ordered = dataSource.fetchOrdered()
    }
    
    // MARK: - Actions
    func setFavorite(_ product: Product) {
        dataSource.setFavorite(product)
        loadAllData()
    }
    
    func setCart(_ product: Product) {
        dataSource.setCart(product)
        loadAllData()
    }
    
    func setOrdered(_ product: Product) {
        dataSource.setOrdered(product)
        loadAllData()
    }
    
    // MARK: - Sync
    private func reloadProducts() {
        products = dataSource.fetchProducts()
    }
}

