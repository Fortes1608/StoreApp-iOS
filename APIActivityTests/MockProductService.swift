//
//  MockProductService.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 25/08/25.
//

import Foundation
@testable import APIActivity

class MockProductService: ProductServiceProtocol {
    var shouldFail: Bool
    var mockProduct: ProductDTO
    var mockProducts: [ProductDTO]

    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
        self.mockProduct = ProductDTO(
            id: 1,
            title: "Mock Product",
            description: "This is a mock product",
            category: "mock-category",
            price: 9.99,
            rating: 4.5,
            thumbnail: "https://example.com/mock.jpg"
        )
        self.mockProducts = [
            ProductDTO(
                id: 2,
                title: "Another Product",
                description: "Another mock product",
                category: "mock-category",
                price: 19.99,
                rating: 4.8,
                thumbnail: "https://example.com/mock2.jpg"
            )
        ]
    }

    func fetchProduct(id: Int) async throws -> ProductDTO {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return mockProduct
    }

    func fetchProducts() async throws -> [ProductDTO] {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return mockProducts
    }
}
