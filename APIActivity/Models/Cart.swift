//
//  Cart.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 13/08/25.
//

import Foundation
import SwiftData


struct Cart{
    var id: Int
    var products: [Product]
    var total: Double
    
    init(id: Int, products: [Product], total: Double) {
        self.id = id
        self.products = products
        self.total = total
    }
}
