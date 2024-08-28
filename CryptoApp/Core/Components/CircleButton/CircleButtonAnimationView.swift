//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by mac on 26/08/2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate : Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 25.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration:1.0) : .none)
        
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
        .foregroundColor(.red)
        .frame(width: 100,height: 100)
}

