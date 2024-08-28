//
//  CircleButtonVIew.swift
//  CryptoApp
//
//  Created by mac on 26/08/2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50,height: 50)
            .background(
                Circle().foregroundColor(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10)
    }
}

#Preview {
    Group {
        CircleButtonView(iconName: "info")
            .previewLayout(.sizeThatFits)
        CircleButtonView(iconName: "plus")
            .previewLayout(.sizeThatFits)
            .colorScheme(.dark)
    }
    
}
