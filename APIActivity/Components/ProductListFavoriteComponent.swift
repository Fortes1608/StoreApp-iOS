//
//  ProductListFavoriteComponent.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI

struct ProductListFavoriteComponent: View {
    
    var product: Product
    var onCartTapped: (() -> Void)?  // closure opcional para ação do botão
    
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
                
                Text(product.titleAPI)
                    .font(.footnote)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                
                Text("US$ \(product.priceAPI, specifier: "%.2f")")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // cart symbol
            Button {
                // action
                onCartTapped?()  // chama a ação externa
            } label: {
                Image(systemName: "cart.fill")
                    .foregroundStyle(.labelsPrimary)
                    .frame(width: 38, height: 38)
                    .background(.fillsTertiary)
                    .cornerRadius(8)
                    .padding(8)
                    .frame(alignment: .center)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.backgroundsSecondary)
        )
    }
    
}

#Preview {
    ProductListFavoriteComponent(
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
