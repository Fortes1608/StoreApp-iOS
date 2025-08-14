//
//  HomeScreen.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 14/08/25.
//

import SwiftUI

struct HomeScreen: View {
    
    
    let viewModel: ProductViewModel
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            } else {
                List {
                    // MARK: SECTION FOR HIGHLIGHT CHARACTER
                    if let product = viewModel.product {
                        Section(header: Text("Highlight")) {
                            ProductCardComponentLarge(product: product)
                        }
                    }
                    
                    // MARK: SECTION FOR CHARACTERS
                    Section(header: Text("All Products")) {
                        ForEach(viewModel.products) { product in
                            ProductCardComponentLarge(product: product)
                        }
                    }
                }
                .navigationTitle("Products")
                .refreshable {
                    await viewModel.loadProducts()
                }
            }
        }
        .task {
            await viewModel.loadProducts()
        }
        
        
           
        
    }
}

#Preview {
    HomeScreen(viewModel: ProductViewModel(service: ProductService()))
}
