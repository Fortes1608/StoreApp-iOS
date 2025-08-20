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
    var product2 = Product()
    
    var body: some View {
        Button {
            productData.setFavorite(product2.fromDTO(product))
        } label: {
            Image(systemName: product2.fromDTO(product).isFavorite ? "heart.fill" : "heart")
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

