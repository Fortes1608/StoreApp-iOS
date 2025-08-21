//
//  TabBar.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI
import SwiftData

struct TabBar: View {
    
    @ObservedObject var productData: ProductDataViewModel
    let viewModel: ProductViewModel
    
    var body: some View {

        TabView {
            
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    HomeScreen(productData: productData, viewModel: viewModel)
                }
            }
            Tab("Category", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    CategoriesScreen(viewModel: viewModel, productData: productData)
                }
            }
            Tab("Cart", systemImage: "cart.fill") {
                NavigationStack {
                    CartScreen(productData: productData)
                }
            }
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    FavoritesScreen(productData: productData)
                }
            }
            Tab("Orders", systemImage: "bag.fill") {
                NavigationStack{
                    OrdersScreen(productData: productData)
                }
            }
            
        }
        
    }
    
}

//#Preview {
//    TabBar(viewModel: ProductViewModel(service: ProductService()))
//}
