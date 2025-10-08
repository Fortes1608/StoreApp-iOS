//
//  ProductListDeliveryComponent.swift
//  APIActivity
//
//  Created by Bernardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI



struct ProductListDeliveryComponent: View {
    
    let myFormat = Date.FormatStyle()
        .minute(.omitted)
        .second(.omitted)
        .year(.omitted)
        .day(.defaultDigits)
        .month(.wide)
        .hour(.omitted)
        .locale(.current)
        
    
    var product: Product
    
    var price: Double
    
    var body: some View {
        HStack(spacing: 16) {
            
            // product image
            AsyncImage(url: URL(string: product.thumbnailAPI)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 78, height: 78)
                    .cornerRadius(8)
            } placeholder: {
                Image(.placeholder)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 78, height: 78)
                    .cornerRadius(8)
            }
            
            // product name & price
            VStack(alignment: .leading, spacing: 4) {
                
                Text("DELIVERY BY \(product.date.formatted(myFormat))")
                    .textCase(.uppercase)
                    .font(Font.caption)
                    .foregroundStyle(Color(.secondaryLabel))
                
                Text(product.titleAPI)
                    .font(.footnote)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                
                Text("US$ \(price, specifier: "%.2f")")
                    .font(.headline)
            }
            .padding(.trailing, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.backgroundsSecondary)
        )
    }
    
}

