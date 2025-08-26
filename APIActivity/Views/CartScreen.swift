//
//  CartScreen.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 15/08/25.
//

import SwiftUI

struct CartScreen: View {
    
    @ObservedObject var productData: ProductDataViewModel
    var body: some View {
        
        if productData.cart.isEmpty {
            CartScreenEmptyState()
                .onAppear {
                    productData.refreshCart()
                }
        }
        
        else {
            ScrollView{
                VStack(spacing:16){
                    ForEach (productData.cart) { product in
                        ProductListCartComponent(product: product, productData: productData)
                    }
                }
                
                .padding(.horizontal, 16)
                .navigationTitle("Cart")
            }
            .onAppear {
                productData.refreshCart()
            }
            .padding(.top, 16)
            VStack{
                HStack{
                    Text("Total")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("US$: \(productData.totalPrice(), specifier: " %.2f")")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                        
                }
                Button{
                    guard !productData.cart.isEmpty else { return }
                    productData.setOrdered(productData.cart)
                    
                }label: {
                    Text("Checkout")
                        .frame(width: 361, height: 54)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.labelsPrimary)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .tint(.fillsTertiary))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        
        
        
    }
}


//#Preview {
//    CartScreen()
//}
