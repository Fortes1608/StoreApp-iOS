//
//  UserViewModel.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 18/08/25.
//

import SwiftData
import Foundation

class ProductDataViewModel: ObservableObject, ProductDataViewModelProtocol {
    
    @Published var products: [Product] = []
    
    internal var dataSource: SwiftDataService
    
    init(service: SwiftDataService) {
        self.dataSource = service
        products = service.fetchProducts()
    }
    
    func setFavorite(_ product: Product) {
        dataSource.setFavorite(product)
        products.append(product)
    }
    
    func setCart(_ product: Product) {
        dataSource.setCart(product)
    }
    
    func setOrdered(_ product: Product) {
        dataSource.setOrdered(product)
    }
    
}
