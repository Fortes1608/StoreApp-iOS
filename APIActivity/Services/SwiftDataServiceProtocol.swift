//
//  CharacterServiceProtocol.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import SwiftData

protocol SwiftDataServiceProtocol {
    
    func fetchProducts() -> [Product]
    func fetchFavorites() -> [Product]
    func fetchCart() -> [Product]
    func fetchOrders() -> [Product]
    func addProduct(_ product: Product)
    func removeProduct(_ product: Product)
    func setFavorite(_ product: Product)
    func setCart(_ product: Product)
    func setOrdered(_ product: [Product])
    func updateProductQuantity(productId: Int, newQuantity: Int)
//    func cleanupOrphanedProducts()
    
}
