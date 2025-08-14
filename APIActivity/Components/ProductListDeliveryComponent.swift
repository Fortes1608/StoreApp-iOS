//
//  ProductListDeliveryComponent.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI

struct ProductListDeliveryComponent: View {
    
    var product: Product
    
    var body: some View {
        HStack(spacing: 16) {
            
            // product image
            AsyncImage(url: URL(string: product.thumbnailAPI)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 78, height: 78)
                    .cornerRadius(8)
            } placeholder: {
                Image(.placeholder)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 78, height: 78)
                    .cornerRadius(8)
            }
            
            // product name & price
            VStack(alignment: .leading, spacing: 4) {
                
                Text("DELIVERY BY MONTH, 00") /// como eu vou saber isso? rever depois!
                    .textCase(.uppercase)
                    .font(Font.caption)
                    .foregroundStyle(Color(.secondaryLabel))
                
                Text(product.titleAPI)
                    .font(.footnote)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                
                Text("US$ \(product.priceAPI, specifier: "%.2f")")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.backgroundsSecondary)
        )
    }
    
}

#Preview {
    ProductListDeliveryComponent(
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
