//
//  DataScannerView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 24/4/2024.
//

import Foundation
import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable {
    
    @Binding var recognizedItems: [RecognizedItem]

//    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let recognizeMultipleItems: Bool
    
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc = DataScannerViewController(
            recognizedDataTypes: [.barcode()],
            qualityLevel: .fast,
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
            
            
        )
        return vc
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems)
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        
        @Binding var recognizedItems: [RecognizedItem]

        init(recognizedItems: Binding<[RecognizedItem]>) {
            self._recognizedItems = recognizedItems
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            print("didTapOn \(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            @State var isPresented = false
            
            //provides vibration on success to user
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            
            
            recognizedItems.append(contentsOf: addedItems)
            
//            print("RecognisedItemsList \(recognizedItems)")
//            self.recognizedItems = recognizedItems.filter { item in
//                
//                if let index = recognizedItems.firstIndex(where: { $0.id == item.id }) {
//                    // If the item is found in recognizedItems
//                    return false // Exclude item from recognizedItems
//                } else {
//                    // If the item is not found in recognizedItems
//                    
//                    return true // Include item in recognizedItems
//                }
//            }
            
            
            
//            print("didAddItems\(addedItems)")
        }
        
        
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            self.recognizedItems = recognizedItems.filter { item in
                //only filters items that is not contained in removedItems array, if is contained, remove from RecognizedItem array
                !removedItems.contains(where: {$0.id == item.id})
            }
            
           

            print("didRemovedAllItems \(removedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("became unavailable with error \(error.localizedDescription)")
        }
        
    }
}
