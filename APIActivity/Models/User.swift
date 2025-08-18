//
//  User.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 13/08/25.
//

import Foundation
import SwiftData


struct User: Identifiable {
    var id: UUID = UUID()
    var cart: Cart
    var orders: [Order]
    
    init(cart: Cart, orders: [Order]) {
        self.cart = cart
        self.orders = orders
    }
}
