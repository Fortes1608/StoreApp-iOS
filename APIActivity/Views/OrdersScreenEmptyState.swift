//
//  OrdersScreenEmptyState.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 21/08/25.
//

import SwiftUI

struct OrdersScreenEmptyState: View {
    var body: some View {
        NavigationStack{
            VStack(spacing: 16) {
                
                Image(systemName: "bag.badge.questionmark")
                    .font(.system(size: 48, weight: .regular))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.graysGray2)
                
                Text("No orders yet")
                    .font(.system(size: 17, weight: .semibold))
                
                Text("Buy an item and it will show up here.")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.labelsSecondary)
                
            }
            .navigationTitle(Text("Cart"))
        }
    }
}

#Preview {
    OrdersScreenEmptyState()
}
