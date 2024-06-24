//
//  AppViewModel.swift
//  SDDProject
//
//  Created by Luke Albrecht on 24/4/2024.
//

import AVKit
import Foundation
import SwiftUI
import VisionKit

enum DataScannerAccessStatusType {
    case notDetermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}

enum ScanType: String {
    case text, barcode
}
//The following code is all about getting access to the camera in order to obtain a video feed

@MainActor
final class AppViewModel: ObservableObject {
    
    //onboarding
    @AppStorage("isOnboarding") var isOnboarding: Bool = true {
            didSet {
                objectWillChange.send()
            }
        }
        
        func finishOnboarding() {
            isOnboarding = false
        }
    
    
    //preferences for user//
    @Published var inedIng: [String: [String]] = [
        "Lactose Free": [
                "Milk", "Cream", "Cheese", "Butter", "Whey", "Whey protein concentrate",
                "Whey protein isolate", "Casein", "Caseinates", "Lactose", "Lactose monohydrate",
                "Milk solids", "Milk powder", "Condensed milk", "Evaporated milk", "Sour cream",
                "Yogurt", "Buttermilk", "Curds", "Custard", "Ghee", "Half-and-half",
                "Ice cream", "Milkfat", "Nonfat dry milk", "Pudding", "Ricotta", "Skim milk",
                "Milk protein concentrate", "Lactalbumin", "Lactoglobulin", "Lactitol", "Malted milk",
                "Curds", "Nougat", "Artificial butter flavor", "Caramel color", "Dairy",
                "Paneer", "Kefir", "Mascarpone", "Quark", "Sherbet", "Sour cream solids"
            ],
            "Gluten": [
                "Wheat", "Barley", "Rye", "Triticale", "Spelt", "Kamut", "Farina", "Graham flour",
                "Semolina", "Durum", "Einkorn", "Emmer", "Farro", "Udon", "Seitan", "Malt", "Malt vinegar",
                "Brewer's yeast", "Couscous", "Orzo", "Matzo", "Pasta", "Cakes", "Cookies", "Crackers",
                "Pizza crust", "Pies", "Pastries", "Cereals", "Bread crumbs", "Croutons", "Soy sauce",
                "Gravies", "Dextrin", "Modified food starch", "Maltodextrin", "Bulgar", "Bran",
                "Oats (unless labeled gluten-free)", "Wheat starch", "Wheat germ"
            ],
            "Paleo": [
                "Wheat", "Rye", "Barley", "Corn", "Rice", "Oats", "Sorghum", "Millet", "Quinoa", "Amaranth",
                "Soybeans", "Soy products", "Tofu", "Soy sauce", "Peanuts", "Peanut butter",
                "Lentils", "Black beans", "Chickpeas", "Lima beans", "Kidney beans", "Pinto beans",
                "Butter beans", "Broad beans", "Snow peas", "Sugar snap peas", "Dairy", "Cheese",
                "Milk", "Yogurt", "Cream", "Ice cream", "Butter", "Refined sugar", "High fructose corn syrup",
                "Aspartame", "Sucralose", "Agave nectar", "Maple syrup", "Honey", "Sodas", "Alcohol",
                "Processed vegetable oils", "Canola oil", "Corn oil", "Soybean oil", "Sunflower oil",
                "Safflower oil", "Grapeseed oil", "Margarine", "Shortening", "Trans fats", "Fast food",
                "Candy", "Pastries", "Junk food", "Artificial sweeteners", "MSG"
            ],
            "Flexitarian": [
                "Red meat", "Processed meat", "Bacon", "Sausages", "Hot dogs", "Cold cuts", "Salami",
                "Pepperoni", "Lamb", "Mutton", "Pork", "Beef", "Veal", "Duck", "Goose", "Sugary beverages",
                "Sodas", "Energy drinks", "Sports drinks", "Fruit juices with added sugar",
                "Fast food", "Fried foods", "Chicken nuggets", "French fries", "Onion rings", "High-sugar snacks",
                "Candy", "Chocolate bars", "Cookies", "Cakes", "Pastries", "Refined grains",
                "White bread", "White rice", "White pasta", "Highly processed foods", "Pre-packaged meals",
                "Instant noodles", "Snack bars", "Microwave popcorn"
            ],
            "Vegetarian": [
                "Meat", "Beef", "Pork", "Lamb", "Mutton", "Veal", "Goat", "Poultry", "Chicken", "Turkey",
                "Duck", "Goose", "Fish", "Salmon", "Tuna", "Trout", "Shellfish", "Shrimp", "Crab", "Lobster",
                "Oysters", "Scallops", "Gelatin", "Animal rennet", "Rennet (not labeled vegetarian)",
                "Lard", "Tallow", "Suet", "Fish sauce", "Anchovy paste", "Certain food colorings (e.g., carmine)",
                "Certain vitamin supplements (e.g., those containing gelatin)", "Certain types of cheese (those made with animal rennet)",
                "Chicken broth", "Beef broth", "Meat-based gravies", "Marshmallows (unless vegetarian)"
            ],
            "Vegan": [
                "Meat", "Beef", "Pork", "Lamb", "Mutton", "Veal", "Goat", "Poultry", "Chicken", "Turkey",
                "Duck", "Goose", "Fish", "Salmon", "Tuna", "Trout", "Shellfish", "Shrimp", "Crab", "Lobster",
                "Oysters", "Scallops", "Dairy", "Milk", "Cheese", "Butter", "Yogurt", "Cream", "Ice cream",
                "Eggs", "Egg whites", "Egg yolks", "Mayonnaise", "Honey", "Bee pollen", "Royal jelly",
                "Gelatin", "Casein", "Whey", "Lactose", "Albumin", "Carmine", "Shellac", "Isinglass",
                "Certain food colorings (e.g., cochineal)", "Certain vitamin supplements (e.g., those containing gelatin)",
                "Certain types of wine and beer (those clarified with animal products)", "Certain baked goods (those containing animal fats or dairy)",
                "Certain types of sugar (those processed with bone char)", "Confectioner's glaze", "L-cysteine"
            ],
            "Pescatarian": [
                "Meat", "Beef", "Pork", "Lamb", "Mutton", "Veal", "Goat", "Poultry", "Chicken", "Turkey",
                "Duck", "Goose", "Gelatin", "Animal rennet", "Rennet (not labeled vegetarian)",
                "Lard", "Tallow", "Suet", "Certain food colorings (e.g., carmine)"
            ],
            "Keto": [
                "Sugar", "Sucrose", "High fructose corn syrup", "Agave nectar", "Honey", "Maple syrup",
                "Grains", "Wheat", "Rice", "Oats", "Corn", "Barley", "Rye", "Starchy vegetables",
                "Potatoes", "Sweet potatoes", "Yams", "Peas", "Corn", "High-sugar fruits", "Bananas",
                "Mangoes", "Pineapples", "Grapes", "Beans", "Lentils", "Chickpeas", "Black beans",
                "Kidney beans", "Pinto beans", "Lima beans", "Low-fat dairy", "Skim milk", "Low-fat yogurt",
                "Certain types of alcohol", "Beer", "Certain cocktails", "Sugary drinks", "Sodas", "Fruit juices",
                "Sports drinks", "Energy drinks", "Most processed foods", "Packaged snacks", "Baked goods",
                "Certain condiments and sauces", "Ketchup", "Barbecue sauce", "Teriyaki sauce", "Certain root vegetables",
                "Carrots", "Parsnips", "Turnips"
            ],
            "Halal": [
                "Pork", "Ham", "Bacon", "Sausages (unless Halal certified)", "Pepperoni", "Salami",
                "Pork products", "Gelatin (from non-Halal sources)", "Animal enzymes (from non-Halal sources)",
                "Lard", "Tallow (unless Halal certified)", "Carnivorous animals", "Birds of prey",
                "Blood", "Blood products", "Improperly slaughtered animals", "Alcohol", "Beer", "Wine", "Spirits",
                "Certain food additives (e.g., those derived from non-Halal sources)", "Vanilla extract (if contains alcohol)",
                "Certain types of vinegar (e.g., wine vinegar)"
            ],
            "Kosher": [
                "Pork", "Ham", "Bacon", "Sausages (unless Kosher certified)", "Pepperoni", "Salami",
                "Shellfish", "Shrimp", "Crab", "Lobster", "Oysters", "Scallops", "Mixing meat and dairy",
                "Cheeseburgers", "Meat lasagna with cheese", "Improperly slaughtered animals",
                "Certain types of gelatin", "Gelatin (from non-Kosher sources)", "Certain types of wine and grape juice",
                "Wine (not produced under kosher supervision)", "Grape juice (not produced under kosher supervision)",
                "Certain additives and preservatives (e.g., those derived from non-kosher sources)",
                "Certain types of cheese", "Cheese (not produced under kosher supervision)"
            ]
        
    ]
    @Published var inedIngPreferences: [String] = []
    
    init() {
        loadInedIng()
    }
    
    func toggleInedIng(_ preference: String) {
        if inedIngPreferences.contains(preference) {
            inedIngPreferences.removeAll { $0 == preference }
        } else {
            inedIngPreferences.append(preference)
        }
        saveInedIng()
    }
    
    private func saveInedIng() {
        UserDefaults.standard.set(inedIngPreferences, forKey: "selectedPreferences")
    }
    
    private func loadInedIng() {
        if let savedPreferences = UserDefaults.standard.array(forKey: "selectedPreferences") as? [String] {
            inedIngPreferences = savedPreferences
        }
    }
    
    
    //data scanner setup//
    
    @Published var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var scanType: ScanType = .barcode
    @Published var textContentType: DataScannerViewController.TextContentType?
    @Published var recognizesMultipleItems = true
    @Published var selectedTab: Int = 1
    
    var recognizedDataType: DataScannerViewController.RecognizedDataType {
        scanType == .barcode ? .barcode() : .text(textContentType: textContentType)
    }
    
    var headerText: String {
        if recognizedItems.isEmpty {
            return "Scanning \(scanType.rawValue)"
        } else {
            return "Recognized \(recognizedItems.count) item(s)"
        }
    }
    
    var dataScannerViewId: Int {
        var hasher = Hasher()
        hasher.combine(scanType)
        hasher.combine(recognizesMultipleItems)
        if let textContentType {
            hasher.combine(textContentType)
        }
        return hasher.finalize()
    }
    
    
    
    //All cases for camera permissions
    
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    func requestDataScannerAccessStatus() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            dataScannerAccessStatus = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable: .scannerNotAvailable
            
            case .restricted, .denied:
                dataScannerAccessStatus = .cameraAccessNotGranted
            
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            } else {
                dataScannerAccessStatus = .cameraAccessNotGranted
            }
            
        default: break
            
        
        }
    }
}
