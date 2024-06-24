//
//  SDDProjectApp.swift
//  SDDProject
//
//  Created by Luke Albrecht on 23/4/2024.
//

import SwiftUI
import SwiftData

import SwiftUI

@main
struct SDDProjectApp: App {
    @StateObject private var vm = AppViewModel()

    var body: some Scene {
        WindowGroup {
            if vm.isOnboarding {
                TitlePageView()
                    .environmentObject(vm)
            } else {
                TabView {
                    CameraView(foundBarcode: "0")
                        .modelContainer(for: SavedItems.self)
                        .environmentObject(vm)
                        .task {
                            await vm.requestDataScannerAccessStatus()
                        }
                        .tag(1)
                        .tabItem {
                            Label("Scan", systemImage: "camera")
                        }
                        .toolbarBackground(.visible, for: .tabBar)
                    
                    ListView()
                        .modelContainer(for: SavedItems.self)
                        .environmentObject(vm)
                        .tag(2)
                        .tabItem {
                            Label("History", systemImage: "list.clipboard")
                        }
                }
            }
        }
    }
}
