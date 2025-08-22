//
//  HomeScreen.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 14/08/25.
//

import SwiftUI

struct HomeScreen: View {
    @Binding var selectedTab: Int
    
    @ObservedObject var productData: ProductDataViewModel
    var viewModel: ProductViewModel
    
    @State private var selectedProduct: ProductDTO?
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    } else {
                        dealsSection
                        topPicksSection
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
        .sheet(item: $selectedProduct) { selectedProduct in
            DetailsSheet(
                selectedTab: $selectedTab, product: selectedProduct,
                viewModel: viewModel,
                productData: productData
            )
            .presentationDragIndicator(.visible)
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var dealsSection: some View {
        if let firstProduct = viewModel.products.first {
            Section(header: Text("Deals of the day")
                .font(.title2)
                .fontWeight(.bold)
            ) {
                ProductCardComponentLarge(
                    selectedTab: $selectedTab, viewModel: viewModel,
                    productData: productData,
                    product: firstProduct
                )
                .onTapGesture {
                    self.selectedProduct = firstProduct
                }
            }
        }
    }
    
    @ViewBuilder
    private var topPicksSection: some View {
        Section(header: Text("Top picks")
            .font(.title2)
            .fontWeight(.bold)
        ) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.products) { product in
                    ProductCardComponentMedium(
                        selectedTab: $selectedTab, viewModel: viewModel,
                        productData: productData,
                        productDTO: product
                    )
                    .onTapGesture {
                        self.selectedProduct = product
                    }
                }
            }
        }
    }
}
