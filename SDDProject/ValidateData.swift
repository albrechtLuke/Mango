//
//  ValidateData.swift
//  SDDProject
//
//  Created by Luke Albrecht on 29/4/2024.
//

import Foundation

func isEAN13(_ barcode: String) -> Bool {
    guard barcode.count == 13 else {
        return false // EAN-13 barcodes must have exactly 13 digits
    }
    print(barcode)
    
    // Convert the barcode string to an array of integers
    let digits = barcode.compactMap { Int(String($0)) }
    print(digits)
    
    guard digits.count == 13 else {
        return false // The barcode must contain only numeric digits
    }
    return true
}
