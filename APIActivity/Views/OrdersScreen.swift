//
//  OrdersScreen.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 21/08/25.
//

import SwiftUI

struct OrdersScreen: View {
    @ObservedObject var productData: ProductDataViewModel
    @State private var searchText: String = ""
    
    
    
    var filteredOrdered: [Product] {
        if searchText.isEmpty {
            return productData.ordered
        } else {
            return productData.ordered.filter { $0.titleAPI.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func listProducts() -> some View {
        ForEach (filteredOrdered) { product in
            return ProductListDeliveryComponent(product: product, price: (product.priceAPI*Double(product.quantity)))
        }
    }
        
        var body: some View {
            if productData.ordered.isEmpty {
                OrdersScreenEmptyState()
            } else {
                ScrollView{
                    VStack(spacing:16){
                        listProducts()
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    .navigationTitle(Text("Orders"))
                    .searchable(text: $searchText, prompt: "Search")
                }
                .onAppear {
                    self.productData.refreshOrdered()
                }
                .onDisappear {
                    for product in productData.ordered {
                        product.quantity = 1
                    }
                }
            }
        }
    }
    
    //#Preview {
    //    OrdersScreen()
    //}
