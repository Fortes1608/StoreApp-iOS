//
//  ProductListCartComponent.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI

struct ProductListCartComponent: View {
    
    var product: Product
    @ObservedObject var productData: ProductDataViewModel
//    var viewModel: ProductViewModel
    
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
            
            // product quantity controls
            HStack(spacing: 8) {
                
                // decrease quantity button
                Button {
                    decreaseQuantity()
                } label: {
                    Image(systemName: "minus")
                        .frame(width: 23, height: 23)
                        .foregroundStyle(.labelsPrimary)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.fillsQuaternary)
                        )
                }
                
                // quantity text
                Text("\(product.quantity)")
                
                // increase quantity button
                Button {
                    increaseQuantity()
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 23, height: 23)
                        .foregroundStyle(.labelsPrimary)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.fillsQuaternary)
                        )
                }
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.backgroundsSecondary)
        )
    }
    
    func increaseQuantity() {
        let newQuantity = product.quantity + 1
        productData.dataSource.updateProductQuantity(productId: product.idAPI, newQuantity: newQuantity)
        print("product quantity increased")
        
        productData.refreshCart()
    }
    
    func decreaseQuantity() {
        if product.quantity == 0 { return }
        let newQuantity = product.quantity - 1
        productData.dataSource.updateProductQuantity(productId: product.idAPI, newQuantity: newQuantity)
        print("product quantity decreased")
        
        productData.refreshCart()
    }
}


//// MARK: Preview
//#Preview {
//    ProductListCartComponent(
//        product: Product(
//            idAPI: 1,
//            titleAPI: "Essence Mascara Lash Princess",
//            descriptionAPI: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
//            categoryAPI: "beauty",
//            priceAPI: 9.99,
//            ratingAPI: 4.94,
//            thumbnailAPI: ""
//        )
//    )
//}
