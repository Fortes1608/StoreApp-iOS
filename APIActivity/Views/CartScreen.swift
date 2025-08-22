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
                    // Validar que o carrinho não está vazio
                    guard !productData.cart.isEmpty else { return }
                    
                    // Criar uma cópia dos produtos para evitar problemas de referência
                    let productsToOrders = productData.cart.map { Product(from: $0) }
                    
                    // Fazer checkout
                    productData.setOrdered(productsToOrders)
                    
                    // Debug para verificar o estado após checkout
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        productData.debugProductStates()
                    }
                    
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
            .onAppear {
                self.productData.refreshCart()
            }
        }
        
        
        
    }
}

//#Preview {
//    CartScreen()
//}
