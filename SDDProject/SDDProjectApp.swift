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

    var body: some Scene {
        WindowGroup {
            CameraView()
                .environmentObject(vm)
            //request scanner access
                .task {
                    await vm.requestDataScannerAccessStatus()
                }
        }
        
    }
}
