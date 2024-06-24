//
//  IngredientsComparison.swift
//  SDDProject
//
//  Created by Luke Albrecht on 8/6/2024.
//

import Foundation
import SwiftUI


class IngredientComparator {
    
    static func compareIngredients(apiIngredients: [String], userPreferences: [String: [String]]) -> [ListItem] {
        var listItems: [ListItem] = []
        
        for ingredient in apiIngredients {
            var matchFound = false
            for (preference, ingredientsList) in userPreferences {
                if ingredientsList.contains(where: { $0.caseInsensitiveCompare(ingredient) == .orderedSame }) {
                    matchFound = true
                    break
                }
            }
            let color: Color? = matchFound ? .red : nil
            listItems.append(ListItem(name: ingredient, consumableColor: color, indent: false))
        }
        
        return listItems
    }
}
