//
//  DetailsSheet.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 15/08/25.
//

import SwiftUI

struct DetailsSheet: View {
    var place: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lobortis nec mauris ac placerat. Cras pulvinar dolor at orci semper hendrerit. Nam elementum leo vitae quam commodo, blandit ultricies diam malesuada. Suspendisse lacinia euismod quam interdum mollis. Pellentesque a eleifend ante. Aliquam tempus ultricies velit, eget consequat magna volutpat vitae. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris pulvinar vestibulum congue. Aliquam et magna ultrices justo condimentum varius."
    var product: Product?
    var viewModel: ProductViewModel

    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 16){
                    ZStack(alignment: .topTrailing){
                        
                        AsyncImage(url: URL(string: product?.thumbnailAPI ?? "")) { image in image
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
                        FavoriteButton(viewModel: viewModel, product: product!)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.backgroundsSecondary)
                    )
                    VStack(alignment: .leading, spacing:16){
                        VStack(alignment: .leading, spacing: 4){
                            Text(product?.titleAPI ?? "Name of a product with two or more lines goes here")
                                .lineLimit(2)
                                .font(.title3)
                            Text("US$ \(product?.priceAPI ?? 00.00, specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        Text(product?.descriptionAPI ?? place)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .navigationTitle(Text("Details"))
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding(.horizontal, 16)
            
            Button{
                
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

//#Preview {
//    DetailsSheet(product: Product(
//        idAPI: 1,
//        titleAPI: "Essence Mascara Lash Princess",
//        descriptionAPI: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
//        categoryAPI: "beauty",
//        priceAPI: 9.99,
//        ratingAPI: 4.94,
//        thumbnailAPI: ""
//    ) )
//}
