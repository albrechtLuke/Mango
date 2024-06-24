//
//  IngredientComparator.swift
//  SDDProject
//
//  Created by Luke Albrecht on 8/6/2024.
//

import Foundation
import SwiftUI

class IngredientComparator {
    
    static func compareIngredients(apiIngredients: [String], userPreferences: [String: [String]]) -> [(ListItem, String?)] {
        var listItems: [(ListItem, String?)] = []
        
        for ingredient in apiIngredients {
            var matchFound = false
            var matchedPreference: String? = nil
            
            for (preference, ingredientsList) in userPreferences {
                if ingredientsList.contains(where: { $0.caseInsensitiveCompare(ingredient) == .orderedSame }) {
                    matchFound = true
                    matchedPreference = preference
                    break
                }
            }
            
            print(userPreferences)
            let listItem = ListItem(name: ingredient, ConsumableColor: matchFound, indent: false, matchingPreference: matchedPreference)
            listItems.append((listItem, matchedPreference))
        }
        
        return listItems
    }
}
