//
//  APIActivityApp.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 13/08/25.
//

import SwiftUI

@main
struct APIActivityApp: App {
    @StateObject var productData: ProductDataViewModel = ProductDataViewModel(service: .shared)

    var body: some Scene {
        WindowGroup {
            TabBar(productData: productData, viewModel: ProductViewModel(service: ProductService()))
        }
        .modelContainer(for: [Product.self])
    }
}
