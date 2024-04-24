//
//  DocumentScannerView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 23/4/2024.
//

import SwiftUI
import VisionKit

@MainActor
struct DocumentScannerView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
        
        
    }
    
    
//    var scannerViewController: DataScannerViewController = DataScannerViewController(
//        recognizedDataTypes: [.text(), .barcode()],
//        qualityLevel: .accurate,
//        recognizesMultipleItems: false,
//        isHighFrameRateTrackingEnabled: false,
//        isHighlightingEnabled: true
//    )
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        
        
        let vc = DataScannerViewController (
            recognizedDataTypes: [.text(), .barcode()],
            qualityLevel: .accurate,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: false,
            isHighlightingEnabled: true
        )
        
        return vc
        
        
        
        
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DocumentScannerView
        var roundBoxMappings: [UUID: UIView] = [:]
        
        init(_ parent: DocumentScannerView) {
            self.parent = parent
        }
        
        // DataScannerViewControllerDelegate - methods starts here
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            //ToDo
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            //ToDo
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didUpdate updatedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            //ToDo
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            //ToDo
        }
        // DataScannerViewControllerDelegate - methods ends here
        
        // Add this method to start scanning
        @objc func startScanning(_ sender: UIButton) {
            try? parent.scannerViewController.startScanning()
        }
    }
}

