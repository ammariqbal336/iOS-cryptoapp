//
//  UIApp.swift
//  CryptoApp
//
//  Created by mac on 29/08/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
