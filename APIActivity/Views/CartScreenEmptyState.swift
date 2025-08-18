//
//  CartScreenEmptyState.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 15/08/25.
//

import SwiftUI

struct CartScreenEmptyState: View {
    var body: some View {
        NavigationStack{
            VStack(spacing: 16) {
                
                Image(systemName: "cart.badge.questionmark")
                    .font(.system(size: 48, weight: .regular))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.graysGray2)
                
                Text("Your cart is empty")
                    .font(.system(size: 17, weight: .semibold))
                
                Text("Add an item to your cart")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.labelsSecondary)
                
            }
            .navigationTitle(Text("Cart"))
        }
    }
}

#Preview {
    CartScreenEmptyState()
}
