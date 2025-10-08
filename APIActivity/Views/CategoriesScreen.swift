//
//  CategoriesScreen.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI

struct CategoryItemView: View {
    
    
    
    let category: ProductCategory
    
    var body: some View {
        
        VStack {
            
            RoundedRectangle(cornerRadius: 16)
                .fill(.fillsSecondary)
                .frame(width: 84, height: 84)
                .overlay(
                    Image(systemName: category.imageName)
                        .font(.system(size: 36))
                        .foregroundColor(.fillsSecondary)
                )
            
            Text(category.localizedName)
                .lineLimit(1)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .frame(width: 80)
            
        }
        
    }
    
}

struct CategoriesScreen: View {
    @Binding var selectedTab: Int
    
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var productData: ProductDataViewModel
    
    @State private var searchText = ""
    
    private var categories: [ProductCategory] {
        ProductCategory.allCases
    }
    
    private var filteredCategories: [ProductCategory] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter { $0.rawValue.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    @Environment(\.horizontalSizeClass) private var hSize
    
    var body: some View {
        NavigationStack {
            Group{
                if hSize == .regular {
                    CategoriesScreenIpad(selectedTab: $selectedTab, viewModel: viewModel, productData: productData, searchText: $searchText)
                } else {
                    
                    
                    VStack(spacing: 24) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                            TextField("Search", text: $searchText)
                                .textFieldStyle(.plain)
                        }
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .navigationTitle("Categories")
                        
                        // Carrossel horizontal clicável
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 12) {
                                ForEach(filteredCategories) { category in
                                    NavigationLink {
                                        CategoryScreen(selectedTab: $selectedTab, productData: productData, viewModel: viewModel, productCategory: category)
                                    } label: {
                                        CategoryItemView(category: category)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 120)
                        
                        List(filteredCategories) { category in
                            NavigationLink {
                                CategoryScreen(selectedTab: $selectedTab, productData: productData, viewModel: viewModel, productCategory: category)
                            } label: {
                                Text(category.localizedName)
                                    .lineLimit(1)
                                    .foregroundStyle(.primary)
                                    .multilineTextAlignment(.leading)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 4)
                            }
                            
                        }
                        .listStyle(.plain)
                    }
                    .background(Color(.systemBackground))
                }
                
            }
            
        }
    }
    struct CategoriesScreenIpad: View {
        
        @Binding var selectedTab: Int
        
        @ObservedObject var viewModel: ProductViewModel
        @ObservedObject var productData: ProductDataViewModel
        
        @Binding var searchText: String
        
        private var categories: [ProductCategory] {
            ProductCategory.allCases
        }
        
        private var filteredCategories: [ProductCategory] {
            if searchText.isEmpty {
                return categories
            } else {
                return categories
                    .filter { $0.rawValue.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        var body: some View {
            NavigationStack {
                VStack(spacing: 24) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Search", text: $searchText)
                            .textFieldStyle(.plain)
                        
                    }
                    .navigationTitle("Categories")
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                        LazyHStack(spacing: 16) {
                            ForEach(filteredCategories.prefix(8)) { category in
                                NavigationLink {
                                    CategoryScreen(selectedTab: $selectedTab, productData: productData, viewModel: viewModel, productCategory: category)
                                } label: {
                                    CategoryItemView(category: category)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    .frame(height: 110)
                    
                    List(filteredCategories.prefix(11)) { category in
                        NavigationLink {
                            CategoryScreen(selectedTab: $selectedTab, productData: productData, viewModel: viewModel, productCategory: category)
                        } label: {
                            Text(category.localizedName)
                                .lineLimit(1)
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical, 16)
                            
                        }
                        
                    }
                    
                    .listStyle(.plain)
                }
                
                .background(Color(.systemBackground))
            }
            .padding(.horizontal, 32)

            
        }
    }
}
//
//#Preview {
//    CategoriesScreen(viewModel: ProductViewModel(service: ProductService()))
//}
//
