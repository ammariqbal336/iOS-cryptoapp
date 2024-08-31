//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by mac on 31/08/2024.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode)  var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("HI")
            }
            .navigationTitle("Edit Portfolio")

            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkView()
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }, label: {
//                        Image(systemName: "xmark")
//                            .font(.headline)
//                    })
                }
            })
        }
        
    }
}

#Preview {
    PortfolioView()
}
