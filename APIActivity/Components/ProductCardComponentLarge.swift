//
//  ProductCardComponent.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 14/08/25.
//

import SwiftUI

struct ProductCardComponentLarge: View {
    @Binding var selectedTab: Int
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var productData: ProductDataViewModel
    var product: ProductDTO
    var body: some View {
        HStack(spacing: 16){
            AsyncImage(url: URL(string: product.thumbnail)) { image in image
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
                        Text(product.fromDTO(product).categoryAPI)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(.labelsSecondary)
                            .textCase(.uppercase)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    FavoriteButton(productData: productData, product: product, selectedTab: $selectedTab)
                }
                
                
                VStack(alignment: .leading){
                    Text(product.title)
                        .font(.system(size: 15, weight: .regular))
                        .lineLimit(2)
                    Text("US$ \(product.price, specifier: "%.2f")")
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
