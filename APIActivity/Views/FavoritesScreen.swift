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
    @Query(filter: #Predicate<Product> { $0.isFavorite == true })
        var favorites: [Product]
    // seria feito de outra maneira daí, a gente faria uma var Query do usuário e pegaria a lista de favoritos
    @StateObject var productData: ProductDataViewModel = ProductDataViewModel(service: .shared)

    var body: some View {
        NavigationStack {
                if productData.dataSource.fetchProducts().isEmpty {
                    FavoritesScreenEmptyState()
                } else {
                    ScrollView {
                        // aqui botaria a lista de favoritos do usuário que está no SwiftData
                        ForEach(favorites) { product in
                                                ProductListFavoriteComponent(product: product)
                                                    .padding(.vertical, 8)
                        }
                        .padding()
                        .frame(alignment: .topLeading)
                        .searchable(text: .constant(""), prompt: "Search")
                    }
                }
        }
        .navigationTitle("Favorites")
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

#Preview {
    FavoritesScreen()
}
