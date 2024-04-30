//
//  LoadingView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 30/4/2024.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct LoadingView: View {
    
    @Binding var isPresented: Bool
    @Binding var foundBarcode: String?
    let barcodeID: String

    var body: some View {
        NavigationStack {
            if barcodeID != "no response yet :(" {
                ApiResponseView(isPresented: $isPresented, foundBarcode: $foundBarcode, barcodeID: barcodeID)
            } else {
//                Text("LoadingView \(barcodeID)")
                LoadingIndicator(size: .large)
            }
        }
        .navigationBarItems(trailing: Button(action: {
            foundBarcode = nil
            isPresented = false
        }) {
            Image(systemName: "x.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding()
        })
        
        
    }
    
    
    
  
}

//#Preview {
//    LoadingView()
//}
