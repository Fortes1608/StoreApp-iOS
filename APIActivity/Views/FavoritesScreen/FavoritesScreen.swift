//
//  FavoritesScreen.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 15/08/25.
//

import SwiftUI
import SwiftData

// MARK: Favorites Screen
struct FavoritesScreen: View {
    @Binding var selectedTab: Int

    var viewModel: ProductViewModel
    @ObservedObject var productData: ProductDataViewModel
    @State private var searchText: String = ""
    @State private var selectedProduct: Product? = nil  // produto selecionado
    @State private var showDetailsSheet: Bool = false   // controla a sheet
    
    var filteredFavorites: [Product] {
        if searchText.isEmpty {
            return productData.favorites
        } else {
            return productData.favorites.filter { $0.titleAPI.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            if productData.favorites.isEmpty {
                FavoritesScreenEmptyState()
            } else {
                ScrollView {
                    ForEach(filteredFavorites) { product in
                        ProductListFavoriteComponent(product: product) {
                            // ação do botão de carrinho
                            selectedProduct = product
                            showDetailsSheet = true
                        }
                        .padding(.bottom, 8)
                    }
                    .padding()
                    .frame(alignment: .topLeading)
                }
                .searchable(text: $searchText, prompt: "Search")
                .onAppear {
                    self.productData.loadAllData()
                }
            }
        }
        .navigationTitle("Favorites")
        .sheet(isPresented: $showDetailsSheet) {
            if let product = selectedProduct {
                DetailsSheet(selectedTab: $selectedTab, product: product.toDTO(), viewModel: viewModel, productData: productData)
                    .presentationDragIndicator(.visible)
            }
        }
    }
}


// MARK: Empty State
struct FavoritesScreenEmptyState: View {
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            Image(systemName: "heart.slash")
                .font(.system(size: 48, weight: .regular))
                .frame(maxWidth: .infinity)
                .foregroundColor(.graysGray2)
            
            Text("No favorites yet!")
                .font(.system(size: 17, weight: .semibold))
            
            Text("Favorite an item and it will show up here.")
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.labelsSecondary)
            
        }
        
    }
    
}
