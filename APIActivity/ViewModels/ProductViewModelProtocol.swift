//
//  UserViewModelProtocol.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import Foundation

@MainActor
protocol ProductViewModelProtocol {
    var product: ProductDTO? { get }
    var products: [ProductDTO] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadProducts() async
}
