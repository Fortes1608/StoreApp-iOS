//
//  TabBar.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI
import SwiftData

struct TabBar: View {
    @State private var selectedTab = 0

    @ObservedObject var productData: ProductDataViewModel
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            NavigationStack {
                HomeScreen(selectedTab: $selectedTab, productData: productData, viewModel: viewModel)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            NavigationStack {
                CategoriesScreen(selectedTab: $selectedTab, viewModel: viewModel, productData: productData)
            }
            .tabItem {
                Label("Category", systemImage: "square.grid.2x2.fill")
            }
            .tag(2)
            
            NavigationStack {
                CartScreen(productData: productData)
            }
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
            .tag(3)
            
            NavigationStack {
                FavoritesScreen(selectedTab: $selectedTab, viewModel: viewModel, productData: productData)
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
            .tag(1)
            
            NavigationStack{
                OrdersScreen(productData: productData)
            }
            .tabItem {
                Label("Orders", systemImage: "bag.fill")
            }
            .tag(4)
        }
    }
}


//#Preview {
//    TabBar(viewModel: ProductViewModel(service: ProductService()))
//}
