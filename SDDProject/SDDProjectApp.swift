//
//  SDDProjectApp.swift
//  SDDProject
//
//  Created by Luke Albrecht on 23/4/2024.
//

import SwiftUI
import SwiftData

@main
struct SDDProjectApp: App {
    //initialise AppViewModel
    @StateObject private var vm = AppViewModel()
    
    //testing variable
    var listItems = [
    ListItem(name: "item1", indent: false),
    ListItem(name: "item2", indent: false),
    ListItem(name: "item3", indent: true),
    ListItem(name: "item4", indent: true),
    ListItem(name: "item5", indent: false)
    ]
    
    
    var body: some Scene {
        WindowGroup {
            TabView {
                
                CameraView()
                    .environmentObject(vm)
                //requesting scanner access
                    .task {
                        await vm.requestDataScannerAccessStatus()
                    }
                    .tag(1)
                    .tabItem {
                        Label("Scan", systemImage: "camera")
                    }
                    .toolbarBackground(.visible, for: .tabBar)

//                DummyResultsView(listItems: listItems, itemTitle: "TEST", itemImage: "image2")
                Text("hello")
                    .tag(2)
                    .tabItem {
                        Label("List", systemImage: "list.clipboard")
                    }
            }
        }
        .modelContainer(for: SavedItems.self)
    }
}
