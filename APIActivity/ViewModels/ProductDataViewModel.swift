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
    
    var dataSource: SwiftDataService
    
    init(service: SwiftDataService) {
        self.dataSource = service
        self.products = service.fetchProducts()
    }
    
    // MARK: - Actions
    func setFavorite(_ product: Product) {
        dataSource.setFavorite(product)
        reloadProducts()
    }
    
    func setCart(_ product: Product) {
        dataSource.setCart(product)
        reloadProducts()
    }
    
    func setOrdered(_ product: Product) {
        dataSource.setOrdered(product)
        reloadProducts()
    }
    
    // MARK: - Sync
    private func reloadProducts() {
        products = dataSource.fetchProducts()
    }
}

