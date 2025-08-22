//
//  ProductCardComponentMedium.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 14/08/25.
//

import SwiftUI

struct ProductCardComponentMedium: View {
    @Binding var selectedTab: Int
    @ObservedObject var productData: ProductDataViewModel
    var productDTO: ProductDTO   // DTO vindo da API
    
    // Transformação para Product do banco
    private var product: Product {
        Product(
            idAPI: productDTO.id,
            titleAPI: productDTO.title,
            descriptionAPI: productDTO.description,
            categoryAPI: productDTO.category,
            priceAPI: productDTO.price,
            ratingAPI: productDTO.rating,
            thumbnailAPI: productDTO.thumbnail
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            ZStack(alignment: .topTrailing){
                AsyncImage(url: URL(string: product.thumbnailAPI)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                } placeholder: {
                    Image(.placeholder)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                }
                
                // 🔹 Passando agora o Product persistido
                FavoriteButton(productData: productData, product: product.toDTO(), selectedTab: $selectedTab)
            }
            
            VStack(alignment: .leading, spacing: 4){
                Text(product.titleAPI)
                    .font(.system(size: 15, weight: .regular))
                    .frame(height: 36)
                Text("US$ \(product.priceAPI, specifier: "%.2f")")
                    .font(.system(size: 17, weight: .semibold))
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.backgroundsSecondary))
        )
        .frame(width: 177, height: 250)
    }
}
