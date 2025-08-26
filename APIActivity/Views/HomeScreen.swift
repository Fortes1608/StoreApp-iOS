import SwiftUI

struct HomeScreen: View {
    @Binding var selectedTab: Int
    
    @ObservedObject var productData: ProductDataViewModel
    @ObservedObject var viewModel: ProductViewModel
    
    @State private var selectedProduct: ProductDTO?
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if viewModel.isLoading {
                        ProgressView()
                            .accessibilityLabel("Loading products")
                            .accessibilityHint("Wait while loading products")
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .accessibilityLabel("Erro: \(errorMessage)")
                    } else {
                        dealsSection
                        topPicksSection
                    }
                }
                .navigationTitle("Home")
                .accessibilityAddTraits(.isHeader)
                .refreshable {
                    await viewModel.loadProducts()
                }
                .accessibilityLabel("Home screen, swipe down to refresh the products")
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
        }
        .task {
            if !viewModel.isLoaded {
                await viewModel.loadProducts()
            }
        }
        .onAppear {
            productData.loadAllData()
        }
        .sheet(item: $selectedProduct) { selectedProduct in
            DetailsSheet(
                selectedTab: $selectedTab, product: selectedProduct,
                viewModel: viewModel,
                productData: productData
            )
            .presentationDragIndicator(.visible)
            .accessibilityLabel("Product details \(selectedProduct.title)")
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var dealsSection: some View {
        if let firstProduct = viewModel.products.first {
            Section(header: Text("Deals of the day")
                .font(.title2)
                .fontWeight(.bold)
                .accessibilityAddTraits(.isHeader)
            ) {
                ProductCardComponentLarge(
                    selectedTab: $selectedTab, viewModel: viewModel,
                    productData: productData,
                    product: firstProduct
                )
                .onTapGesture {
                    self.selectedProduct = firstProduct
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(firstProduct.title), in sale for \(firstProduct.price, specifier: "%.2f") dollars")
                .accessibilityHint("Tap twice to show details")
            }
        }
    }
    
    @ViewBuilder
    private var topPicksSection: some View {
        Section(header: Text("Top picks")
            .font(.title2)
            .fontWeight(.bold)
            .accessibilityAddTraits(.isHeader)
        ) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.products) { product in
                    ProductCardComponentMedium(
                        selectedTab: $selectedTab,
                        productData: productData,
                        productDTO: product
                    )
                    .onTapGesture {
                        self.selectedProduct = product
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("\(product.title), price \(product.price, specifier: "%.2f") dollars")
                    .accessibilityHint("Tap twice to show details")
                }
            }
        }
    }
}
