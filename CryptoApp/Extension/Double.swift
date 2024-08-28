//
//  Double.swift
//  CryptoApp
//
//  Created by mac on 28/08/2024.
//

import Foundation

extension Double {
    
    /// Convert double into current b/w 2  digits
    ///```
    ///Convert 1234.56 to 1,234.56
    ///```
    private var currentFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
       // formatter.locale = .current
       // formatter.currencyCode = "usd"
       // formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
        
    }
    
    /// Convert double into Curreny as a String with 2  decimal places
    ///```
    ///Convert 1234.56 to "$1,234.56"
    ///```
    func asCurrencyWith2Decimal() -> String {
        let number = NSNumber(value: self)
        return currentFormatter2.string(from: number) ?? "$0.00"
        
    }
    
    
    
    /// Convert double into current b/w 2 to 6 digits
    ///```
    ///Convert 1234.56 to 1,234.56
    ///Convert 12.3456 to 12.3456
    ///Convert 0.123456 to 0.123456
    ///```
    private var currentFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
       // formatter.locale = .current
       // formatter.currencyCode = "usd"
       // formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
        
    }
    
    /// Convert double into Curreny as a String with 2 to 6 decimal places
    ///```
    ///Convert 1234.56 to "$1,234.56"
    ///Convert 12.3456 to "$12.3456"
    ///Convert 0.123456 to "$0.123456"
    ///```
    func asCurrencyWith6Decimal() -> String {
        let number = NSNumber(value: self)
        return currentFormatter6.string(from: number) ?? "$0.00"
        
    }
    /// Convert double into string representaton
    ///```
    ///Convert 1234.56 to "1234.56"
    ///Convert 12.3456 to "12.34"
    ///Convert 0.123456 to "0.12"
    ///```
    func asNumberString() -> String {
        return String(format: "%.2f",self)
    }
   
    /// Convert double into string representaton with percent symbol
    ///```
    ///Convert 1234.56 to "1234.56%"
    ///Convert 12.3456 to "12.34%"
    ///Convert 0.123456 to "0.12%"
    ///```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
