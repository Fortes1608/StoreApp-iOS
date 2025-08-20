//
//  CharacterServiceProtocol.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

protocol ProductServiceProtocol{
    func fetchProduct(id: Int) async throws -> Product
    func fetchProducts() async throws -> [ProductDTO]
}
