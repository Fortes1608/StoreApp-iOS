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
    
    var body: some View {
        Button {
            let productToSave = Product(from: product)
            productData.setFavorite(productToSave)
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

