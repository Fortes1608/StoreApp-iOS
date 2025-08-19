//
//  CharacterServiceProtocol.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import SwiftData

protocol SwiftDataServiceProtocol {
    
    func fetchProducts() -> [Product]
    func addProduct(_ product: Product)
    
}
