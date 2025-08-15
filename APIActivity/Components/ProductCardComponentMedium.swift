//
//  ProductCardComponentMedium.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 14/08/25.
//

import SwiftUI

struct ProductCardComponentMedium: View {
    
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            ZStack(alignment: .topTrailing){
                AsyncImage(url: URL(string: product.thumbnailAPI)) { image in image
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
                FavoriteButton()
            }
            
            VStack(alignment: .leading, spacing: 4){
                Text(product.titleAPI)
                    .font(.system(size: 15, weight: .regular))
                    .frame(height: 36)
                Text("US$ \(product.priceAPI, specifier: "%.2f")")
                    .font((.system(size: 17, weight: .semibold)))
            }
            
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.backgroundsSecondary))
            ).frame(width: 177, height: 250)
        
    }
}
#Preview {
    ProductCardComponentMedium(
        product: Product(
            idAPI: 1,
            titleAPI: "Essence Mascara Lash Princess",
            descriptionAPI: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
            categoryAPI: "beauty",
            priceAPI: 9.99,
            ratingAPI: 4.94,
            thumbnailAPI: ""
        )
    )
}
