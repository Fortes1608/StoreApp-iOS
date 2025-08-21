//
//  CategoryScreen.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI

struct CategoryScreen: View {
    
    @ObservedObject var productData: ProductDataViewModel
    let viewModel: ProductViewModel
    let productCategory: ProductCategory
    @State private var selectedProduct : Product?
    @State private var searchText = ""
    
    /// Filtra os produtos por categoria e texto de busca (título ou descrição)
    /// - Retorna: Array de `Product` que atendem aos critérios
    private func getFilteredProducts() -> [ProductDTO] {
        
        // Filtra a lista de produtos da ViewModel
        return viewModel.products.filter { product in
            
            // 1. Verifica se a categoria do produto corresponde à selecionada (ignorando maiúsculas/minúsculas)
            let isSameCategory = product.category.lowercased() == productCategory.rawValue.lowercased()
            
            // 2. Verifica se:
            //    - Não há texto de busca OU
            //    - O texto existe no título (ignorando maiúsculas/minúsculas) OU
            //    - O texto existe na descrição (ignorando maiúsculas/minúsculas)
            let containsSearchText = searchText.isEmpty ||
                                   product.title.localizedCaseInsensitiveContains(searchText) ||
                                   product.description.localizedCaseInsensitiveContains(searchText)
            
            // 3. Retorna apenas produtos que atendem AMBAS condições
            return isSameCategory && containsSearchText
        }
    }
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                        // Grid de produtos
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(getFilteredProducts()) { product in
                                ProductCardComponentMedium(productData: productData, productDTO: product)
                                    .onTapGesture{
                                        self.selectedProduct = product.fromDTO(product)
                                    }
                                    .sheet(item: self.$selectedProduct, content: { selectedProduct in
                                        DetailsSheet(product: selectedProduct.toDTO(), viewModel: viewModel, productData: productData)
                                            .presentationDragIndicator(.visible)
                                    })
                            }
                        }
                        .padding(.horizontal)
                }
                .navigationTitle(productCategory.rawValue)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
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

//#Preview {
//    CategoryScreen(
//        viewModel: ProductViewModel(service: ProductService()),
//        productCategory: ProductCategory.beauty
//    )
//}
