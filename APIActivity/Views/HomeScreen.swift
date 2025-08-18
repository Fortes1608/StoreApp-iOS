//
//  HomeScreen.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 14/08/25.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedProduct: Product?
    
    let viewModel: ProductViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading, spacing: 16) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    } else {
                        
                        if let product = viewModel.product {
                            Section(header: Text("Deals of the day")
                                .font(.title2)
                                .fontWeight(.bold)
                                    
                            ) {
                                ProductCardComponentLarge(product: product)
                                    .onTapGesture{
                                        self.selectedProduct = product
                                    }
                                    .sheet(item: self.$selectedProduct, content: { selectedProduct in
                                        DetailsSheet(product: selectedProduct)
                                            .presentationDragIndicator(.visible)
                                    })
                            }
                        }
                        
                        
                        Section(header: Text("Top picks")
                            .font(.title2)
                            .fontWeight(.bold)
                        ) {
                            LazyVGrid(columns: columns, spacing: 16){
                                ForEach(viewModel.products) {product in
                                    ProductCardComponentMedium(product: product)
                                        .onTapGesture{
                                            self.selectedProduct = product
                                        }
                                        .sheet(item: self.$selectedProduct, content: { selectedProduct in
                                            DetailsSheet(product: selectedProduct)
                                                .presentationDragIndicator(.visible)
                                        })
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Home")
                .refreshable {
                    await viewModel.loadProducts()
                }
                
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            
        }
        .task {
            await viewModel.loadProducts()
        }
        
        
        
        
    }
}
#Preview {
    HomeScreen(viewModel: ProductViewModel(service: ProductService()))
}
