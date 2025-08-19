//
//  FavoriteButton.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 14/08/25.
//

import SwiftUI
import SwiftData

struct FavoriteButton: View {
    
    
    var viewModel: ProductViewModel
    var product: Product
    @StateObject var productData: ProductDataViewModel = ProductDataViewModel(service: .shared)
    
    var body: some View {
        Button {
            productData.dataSource.setFavorite(product)
            print("salvou no swift data")
            print(productData.dataSource.fetchProducts().count)
        }label: {
              
                Text(Image(systemName: product.isFavorite ? "heart.fill" : "heart"))
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

//#Preview {
//    FavoriteButton(viewModel: ProductViewModel(service: ProductService()), isSelected: )
//}
