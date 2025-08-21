//
//  DetailsSheet.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 15/08/25.
//

import SwiftUI

struct DetailsSheet: View {
    @Environment(\.dismiss) private var dismiss
    var product: ProductDTO
    var viewModel: ProductViewModel
    @ObservedObject var productData: ProductDataViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 16){
                    ZStack(alignment: .topTrailing){
                        
                        AsyncImage(url: URL(string: product.thumbnail)) { image in image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 329, height: 329)
                                .cornerRadius(8)
                        }placeholder: {
                            Image(.placeholder)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 329, height: 329)
                                .cornerRadius(8)
                        }
                        FavoriteButton(productData: productData, product: product)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.backgroundsSecondary)
                    )
                    VStack(alignment: .leading, spacing:16){
                        VStack(alignment: .leading, spacing: 4){
                            Text(product.title)
                                .lineLimit(2)
                                .font(.title3)
                            Text("US$ \(product.price, specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        Text(product.description)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .navigationTitle(Text("Details"))
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding(.horizontal, 16)
            
            Button{
                // Criar uma cópia do produto para evitar problemas de referência
                let productToCart = Product(from: product)
                
                // Adicionar ao carrinho de forma segura
                productData.setCart(productToCart)
                print("Added to Cart")
                print(productData.cart)
                
                // Aguardar um pouco antes de fechar para evitar problemas de estado
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    dismiss()
                }
            }label:{
                Text("Add to Cart")
                    .frame(width: 361, height: 54)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(.labelsPrimary)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .tint(.fillsTertiary)
                    )
            }
        }
    }
}
