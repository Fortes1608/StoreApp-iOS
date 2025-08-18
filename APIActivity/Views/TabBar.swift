//
//  TabBar.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI

struct TabBar: View {
    
    let viewModel: ProductViewModel
    
    var body: some View {
        
        TabView {
            
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    HomeScreen(viewModel: viewModel)
                }
            }
            Tab("Category", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    CategoriesScreen(viewModel: viewModel)
                }
            }
            Tab("Cart", systemImage: "cart.fill") {
                
            }
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    FavoritesScreen()
                }
            }
            Tab("Orders", systemImage: "bag.fill") {
                
            }
            
        }
        
    }
    
}

//#Preview {
//    TabBar(viewModel: ProductViewModel(service: ProductService()))
//}
