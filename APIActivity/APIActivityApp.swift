//
//  APIActivityApp.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 13/08/25.
//

import SwiftUI

@main
struct APIActivityApp: App {
    @StateObject var productData: ProductDataViewModel = ProductDataViewModel(service: SwiftDataService.shared)
    @StateObject var productViewModel: ProductViewModel = ProductViewModel(service: ProductService())

    var body: some Scene {
        WindowGroup {
            TabBar(productData: productData, viewModel: productViewModel)
        }
        .modelContainer(for: [Product.self])
    }
}
