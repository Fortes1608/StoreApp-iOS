//
//  MockSwiftDataService.swift
//  APIActivityTests
//
//  Created by Lorenzo Fortes on 25/08/25.
//

import Foundation
@testable import APIActivity


final class MockSwiftDataService: SwiftDataServiceProtocol {
    
    private(set) var products: [Product]
    var shouldFail: Bool
    
    init(shouldFail: Bool = false, seed: [Product] = [
        Product(idAPI: 1, titleAPI: "Mock iPhone", descriptionAPI: "desc", categoryAPI: "Phones", priceAPI: 20, ratingAPI: 4.5, thumbnailAPI: ""),
        Product(idAPI: 2, titleAPI: "Mock MacBook", descriptionAPI: "desc", categoryAPI: "Laptops", priceAPI: 10, ratingAPI: 4.7, thumbnailAPI: "")
    ]) {
        self.shouldFail = shouldFail
        self.products = seed
    }
    
    func fetchProducts() -> [Product] {
        shouldFail ? [] : products
    }
    
    func fetchFavorites() -> [Product] {
        products.filter { $0.isFavorite }
    }
    
    func fetchCart() -> [Product] {
        products.filter { $0.isCart }
    }
    
    func fetchOrders() -> [Product] {
        products.filter { $0.isOrdered }
    }
    
    func addProduct(_ product: Product) {
        if !products.contains(where: { $0.idAPI == product.idAPI }) {
            products.append(product)
        }
    }
    
    func removeProduct(_ product: Product) {
        products.removeAll { $0.idAPI == product.idAPI }
    }
    
    func setFavorite(_ product: Product) {
        if let i = products.firstIndex(where: { $0.idAPI == product.idAPI }) {
            products[i].isFavorite.toggle()
        }
    }
    
    func setCart(_ product: Product) {
        if let i = products.firstIndex(where: { $0.idAPI == product.idAPI }) {
            products[i].isCart.toggle()
        }
    }
    
    func setOrdered(_ orderedProducts: [Product]) {
        for p in orderedProducts {
            if let i = products.firstIndex(where: { $0.idAPI == p.idAPI }) {
                products[i].isOrdered = true
                products[i].isCart = false
                products[i].date = Date()
            }
        }
    }
    
    func updateProductQuantity(productId: Int, newQuantity: Int) {
        if let i = products.firstIndex(where: { $0.idAPI == productId }) {
            products[i].quantity = newQuantity
        }
    }
}
