//
//  ApiResponseView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 29/4/2024.
//

import SwiftUI
import SwiftData
import SwiftfulLoadingIndicators

struct ApiResponseView: View {
    @State private var productName: String = ""
    @State private var productImage: String = ""
    @State private var ingredientsTags: [String] = []
    @Binding var isPresented: Bool
    @Binding var foundBarcode: String?
    let barcodeID: String
    let showErrorToast: (String) -> Void
    
    @ObservedObject var viewModel = AppViewModel()
    
    //Call SwiftData Container
    @Environment(\.modelContext) private var context
    
    var listItems: [ListItem] {
        IngredientComparator.compareIngredients(apiIngredients: ingredientsTags, userPreferences: viewModel.preferences).map { $0.0 }
    }
    
    var matchingPreferences: [String?] {
        IngredientComparator.compareIngredients(apiIngredients: ingredientsTags, userPreferences: viewModel.preferences).map { $0.1 }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if ingredientsTags.isEmpty {
//                        Text("ApiResponseView()")
//                        Text("Loading ingredientsTags: \(barcodeID)...")
//                            .padding()
                        LoadingIndicator(size: .large)
                    } else {
                        ResultsView(listItems: listItems, itemTitle: productName, itemImage: productImage, preferenceMatch: matchingPreferences, isPresented: $isPresented, foundBarcode: $foundBarcode)
                    }
                }
                VStack {
                    Spacer()
                }
            }
        }
        .onAppear {
            Task {
                await fetchData()
            }
        }
        .onChange(of: ingredientsTags, { oldValue, newValue in
            guard !newValue.isEmpty else { return }
            let intBarcode = Int(barcodeID) ?? 0
            let allPreferencesMatched = matchingPreferences.allSatisfy { $0 == nil }
            let item = SavedItems(barcodeID: intBarcode, name: productName, status: allPreferencesMatched, image: productImage)
            context.insert(item)
            print("Item Saved")
        })
        
    }

    func fetchData() async {
        // Define the URL
        let urlString = "https://world.openfoodfacts.org/api/v0/product/\(barcodeID).json"
        
        // Define the URL object
        guard let url = URL(string: urlString) else {
            exitWithError(message: "Invalid URL")
            return
        }
        
        // Define the request object
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Perform the request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check for response status
            guard let httpResponse = response as? HTTPURLResponse else {
                exitWithError(message: "Invalid response")
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                break // Successful response, continue processing
            case 400:
                exitWithError(message: "Bad Request (400)")
                return
            case 401:
                exitWithError(message: "Unauthorized (401)")
                return
            case 403:
                exitWithError(message: "Forbidden (403)")
                return
            case 404:
                exitWithError(message: "Not Found (404)")
                return
            case 500:
                exitWithError(message: "Internal Server Error (500)")
                return
            default:
                exitWithError(message: "Unexpected HTTP status code: \(httpResponse.statusCode)")
                return
            }
            
            // Parse the JSON data
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let product = json["product"] as? [String: Any],
               let productImageValue = product["image_front_url"] as? String,
               let productNameValue = product["product_name"] as? String,
               let ingredientsTagsArray = product["ingredients_tags"] as? [String] {
                // Access the value of the "product_name" key
                productImage = productImageValue
                productName = productNameValue
                
                // Remove "en:" prefix
                ingredientsTags = ingredientsTagsArray.map { $0.replacingOccurrences(of: "en:", with: "") }
                ingredientsTags = ingredientsTags.map { $0.replacingOccurrences(of: "-", with: " ") }
                
                print("productImage:  \(productImage)")
                print("productName:  \(productName)")
            } else {
                exitWithError(message: "Failed to parse JSON")
            }
        } catch {
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                exitWithError(message: "No internet connection")
            } else {
                exitWithError(message: "Error: \(error.localizedDescription)")
            }
        }
    }

    func exitWithError(message: String) {
        print(message)
        showErrorToast(message) // Call the closure to show toast in CameraView
        foundBarcode = nil
        isPresented = false
    }
}
