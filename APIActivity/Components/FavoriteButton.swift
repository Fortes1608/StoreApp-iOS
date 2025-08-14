//
//  FavoriteButton.swift
//  APIActivity
//
//  Created by Lorenzo Fortes on 14/08/25.
//

import SwiftUI

struct FavoriteButton: View {
    @State var isSelected: Bool = false
    var body: some View {
        Button{
            isSelected.toggle()
        }label: {
            Text(Image(systemName: isSelected ? "heart.fill" : "heart"))
                .foregroundStyle(.labelsPrimary)
                .font(.system(size: 20))
                .fontWeight(.regular)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.fillsTertiary)
                )
        }
      
            
    }
        
}

#Preview {
    FavoriteButton()
}
