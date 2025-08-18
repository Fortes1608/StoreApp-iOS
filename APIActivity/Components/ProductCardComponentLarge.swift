//
//  ProductCardComponent.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 14/08/25.
//

import SwiftUI

struct ProductCardComponentLarge: View {
    var viewModel: ProductViewModel
    var product: Product
    var body: some View {
        HStack(spacing: 16){
            AsyncImage(url: URL(string: product.thumbnailAPI)) { image in image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .cornerRadius(8)
                    .padding(.vertical, 8)
                    .padding(.leading, 8)
            } placeholder: {
                Image(.placeholder)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .cornerRadius(8)
                    .padding(.vertical, 8)
                    .padding(.leading, 8)
            }
            
            
            VStack(alignment: .leading, spacing: 24){
                HStack{
                    VStack{
                        Text(product.categoryAPI)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(.labelsSecondary)
                            .textCase(.uppercase)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    FavoriteButton()
                }
                
                
                VStack(alignment: .leading){
                    Text(product.titleAPI)
                        .font(.system(size: 15, weight: .regular))
                        .lineLimit(2)
                    Text("US$ \(product.priceAPI, specifier: "%.2f")")
                        .font((.system(size: 17, weight: .semibold)))
                }
                .padding(.bottom, 32)
            }
            .padding(.vertical, 8)
            .padding(.trailing, 8)
        }
        .padding(.horizontal, 24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.backgroundsSecondary)
                .frame(width: 361, height: 176)
        )
    }
}

#Preview {
    ProductCardComponentLarge(
        viewModel: ProductViewModel(service: ProductService()), product: Product(
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
