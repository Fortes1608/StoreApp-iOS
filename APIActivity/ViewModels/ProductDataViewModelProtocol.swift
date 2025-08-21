//
//  UserViewModelProtocol.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import Foundation
import SwiftData

protocol ProductDataViewModelProtocol {
    var products: [Product] { get set }
    var dataSource: SwiftDataService { get set }
    func setFavorite(_ product: Product)
    func setCart(_ product: Product)
    func setOrdered(_ product: [Product])
}
