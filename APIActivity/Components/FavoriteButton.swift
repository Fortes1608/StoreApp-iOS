//
//  FavoriteButton.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 14/08/25.
//

import SwiftUI
import SwiftData

struct FavoriteButton: View {
    @ObservedObject var productData: ProductDataViewModel
    var product: ProductDTO
    
    // Binding para controlar a aba selecionada na TabView
    @Binding var selectedTab: Int
    
    var body: some View {
        Button {
            productData.setFavorite(Product(from: product))
            
//            // Guarda aba atual
//            let currentTab = selectedTab
//            
//            // Muda para aba de favoritos (ex: 1) e volta imediatamente
//            selectedTab = 1 // índice da aba Favorites
//            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                selectedTab = currentTab
//            }
        } label: {
            let isFavorite = productData.favorites.contains { $0.idAPI == product.id }
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(.labelsPrimary)
                .font(.system(size: 20))
                .fontWeight(.regular)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.fillsTertiary)
                )
        }
    }
}
