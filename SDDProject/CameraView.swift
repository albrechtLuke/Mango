//
//  ContentView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 23/4/2024.
//

import SwiftUI
import VisionKit


struct CameraView: View {
    @EnvironmentObject var vm: AppViewModel
    @State private var isShowingItemFoundView = false
    @State private var foundBarcode: String?
    
    var body: some View {
        NavigationStack {
            
            //Checks the status of gaining access to camera, and displays the appropriate screen
            switch vm.dataScannerAccessStatus {
            case .notDetermined:
                PermissionView(permissionImage: "video", permissionText: "Requesting Camera Access")
            case .cameraAccessNotGranted:
                PermissionView(permissionImage: "video.slash", permissionText: "Please provide access to the camera in settings")
            case .cameraNotAvailable:
                Text("Your device does not have support for scanning barcode with this app!")
                    .fullScreenCover(isPresented: .constant(true), content: {
                        PermissionView(permissionImage: "video.slash", permissionText: "Your device does not have support for scanning barcode with this app!")
                    })
            case .scannerAvailable:
                mainView
            case .scannerNotAvailable:
                    PermissionView(permissionImage: "questionmark.video", permissionText: "Your device does not have a camera")
            }
        }
    }
    

    //Displays camera feed
    private var mainView: some View {
        TabView {
            ZStack {
                DataScannerView(
                    recognizedItems: $vm.recognizedItems,
                    //                recognizedDataType: vm.recognizedDataType,
                    recognizeMultipleItems: vm.recognizesMultipleItems)
                .background { Color.gray.opacity(0.3) }
                .ignoresSafeArea()
                .id(vm.dataScannerViewId)
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(.ultraThinMaterial)
                        
                        //                    .padding(.horizontal)
                        
                        bottomContainerView
                    }
                    .ignoresSafeArea(.all, edges: .bottom)
                    .frame(height: 200)
                }
                
            }
        }
    }
    
    //Displays bottom sheet
    private var bottomContainerView: some View {
        VStack {
            Text(vm.headerText)
                .padding(.top)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    Button("Test Item") {
                        foundBarcode = "5449000131805"
                        isShowingItemFoundView = true
                    }
                    
                    ForEach(vm.recognizedItems.indices, id: \.self) { index in
                        let item = vm.recognizedItems[index]
                        switch item {
                        case .barcode(let barcode):
                            let tempBarcode = barcode.payloadStringValue ?? "Unknown Barcode"
                            Text("Item Found!")
                                .onAppear(perform: {
                                    while foundBarcode == nil {
                                            foundBarcode = tempBarcode
                                            isShowingItemFoundView = true
                                    }
                                    
                                })
                            
                            
//                             Capture the barcode only when isShowingItemFoundView is true
//                            if isShowingItemFoundView {
//                                foundBarcode = tempBarcode
//                            }
                            
                        case .text(let text):
                            Text(text.transcript)
                        @unknown default:
                            Text("Unknown")
                        }
                    }
                    
                }
                .padding()
                .fullScreenCover(isPresented: $isShowingItemFoundView) {
                    LoadingView(isPresented: $isShowingItemFoundView, foundBarcode: $foundBarcode, barcodeID: foundBarcode ?? "no response yet :(")
                }
            }
        }
        
    }
}


//Reusable struct for displaying permission status
struct PermissionView: View {
    
    let permissionImage: String
    let permissionText: String
    
    var body: some View {
        VStack {
            
            Image(systemName: permissionImage)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text(permissionText)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            
        }
    }
}

