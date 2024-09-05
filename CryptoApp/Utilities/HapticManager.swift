//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Muhammad Ammar on 05/09/2024.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
