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




//Possible user preferences
struct PreferencesList {
    static let dictionary: [String: [String]] = [
        "Lactose": [
            "Milk",
            "Cream",
            "Cheese",
            "Butter",
            "Whey",
            "Whey protein concentrate",
            "Whey protein isolate",
            "Casein",
            "Caseinates",
            "Lactose",
            "Lactose monohydrate",
            "Milk solids",
            "Milk powder",
            "Condensed milk",
            "Evaporated milk",
            "Sour cream",
            "Yogurt",
            "Buttermilk",
            "Curds",
            "Custard",
            "Ghee",
            "Half-and-half",
            "Ice cream",
            "Milkfat",
            "Nonfat dry milk",
            "Pudding",
            "Ricotta",
            "Skim milk",
            "Milk protein concentrate",
            "Lactalbumin",
            "Lactoglobulin",
            "Lactitol",
            "Malted milk",
            "Curds",
            "Nougat",
            "Artificial butter flavor",
            "Caramel color"
        ],
        
    ]
}
