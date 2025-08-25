//
//  CharacterViewModel.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import Foundation
import SwiftUI

@MainActor
final class ProductViewModel: ObservableObject, ProductViewModelProtocol {
    @Published var product: ProductDTO?
    @Published var products: [ProductDTO] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoaded: Bool = false
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func loadProducts() async {
        isLoading = true
        
        do {
            product = try await service.fetchProduct(id: 32)
            products = try await service.fetchProducts()
            errorMessage = nil
        } catch {
            errorMessage = "Error to fetch Products: \(error.localizedDescription)"
        }
        
        isLoading = false
        isLoaded = true
    }
}
