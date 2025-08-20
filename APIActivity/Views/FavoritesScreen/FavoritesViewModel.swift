//
//  FavoritesViewModel.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 20/08/25.
//

import Foundation

class FavoritesViewModel {
    var products: [Product] = []
    
    private let service: SwiftDataService
    
    init(service: SwiftDataService) {
        self.service = service
    }
    
    func loadFavoriteProducts() -> [Product] {
        products = service.fetchFavorites()
        
        return products
    }
}
