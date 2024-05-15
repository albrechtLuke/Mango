//
//  SwiftDataModel.swift
//  SDDProject
//
//  Created by Luke Albrecht on 15/5/2024.
//

import Foundation
import SwiftData

@Model
class SavedItems: Identifiable {
    
    var barcodeID: Int
    var name: String
    var status: Bool
    var image: String
    
    init(barcodeID: Int, name: String, status: Bool, image: String) {
        self.barcodeID = barcodeID
        self.name = name
        self.status = status
        self.image = image
    }
}
