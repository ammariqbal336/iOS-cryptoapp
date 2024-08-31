//
//  XMarkView.swift
//  CryptoApp
//
//  Created by mac on 31/08/2024.
//

import SwiftUI


struct XMarkView: View {
    
    @Environment(\.presentationMode)  var presentationMode
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkView()
}
