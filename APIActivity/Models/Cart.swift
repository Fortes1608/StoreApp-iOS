//
//  Cart.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 13/08/25.
//

import Foundation
import SwiftData

@Model
class Cart: Identifiable{
    var id : UUID = UUID()
    var products: [Product]
    var total: Double
    
    init(products: [Product], total: Double) {
        self.products = products
        self.total = total
    }
}
