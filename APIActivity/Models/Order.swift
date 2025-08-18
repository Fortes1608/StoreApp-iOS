//
//  Orders.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 13/08/25.
//

import Foundation
import SwiftData

@Model
class Order: Identifiable{
    var id: UUID = UUID()
    var cart: Cart
    var date: Date

    init(cart: Cart, date: Date) {
        self.cart = cart
        self.date = date
    }
}
