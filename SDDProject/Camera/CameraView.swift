//
//  CameraView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 23/4/2024.
//

import SwiftUI
import VisionKit
import AlertToast

struct CameraView: View {
    @EnvironmentObject var vm: AppViewModel
        @State var isShowingItemFoundView = false
        @State var foundBarcode: String
        @State var showToast = false
        @State var toastMessage = ""
    
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
                    .toast(isPresenting: $showToast) {
                        AlertToast(displayMode: .hud, type: .error(.red), title: toastMessage)
                    }
                
            case .scannerNotAvailable:
                PermissionView(permissionImage: "questionmark.video", permissionText: "Your device does not have a camera")
                Button {
                    updateStateAndShowLoadingView()
                } label: {
                    Text("TestButton")
                }
                .buttonStyle(.bordered)
                .fullScreenCover(isPresented: $isShowingItemFoundView) {
                    ApiResponseView(isPresented: $isShowingItemFoundView, foundBarcode: foundBarcode, showErrorToast: { message in
                        showToast(message)
                    })
                }                
                .toast(isPresenting: $showToast) {
                    AlertToast(displayMode: .hud, type: .error(.red), title: toastMessage)
                }
            }
        }
        .onChange(of: isShowingItemFoundView) { _, newValue in
            if newValue {
                print("isShowingItemFoundView is now true")
//                print("barcodeID: \(barcodeID)")ti
                print("foundBarcode: \(foundBarcode)")
            }
        }
    }
    
    private func updateStateAndShowLoadingView() {
        foundBarcode = "9300633556174"
        isShowingItemFoundView = true
        print("Button pressed. foundBarcode updated.")
    }
    
    // Displays camera feed
    private var mainView: some View {
        TabView {
            ZStack {
                bottomContainerView
                DataScannerView(
                    recognizedItems: $vm.recognizedItems,
                    recognizeMultipleItems: vm.recognizesMultipleItems)
                .background { Color.gray.opacity(0.3) }
                .ignoresSafeArea()
                .id(vm.dataScannerViewId)
                
                                
            }
        }
        .fullScreenCover(isPresented: $isShowingItemFoundView) {
            ApiResponseView(isPresented: $isShowingItemFoundView, foundBarcode: foundBarcode, dontSave: true, showErrorToast: { message in
                showToast(message)
            })
        }
    }
    
    // Displays bottom sheet
    private var bottomContainerView: some View {
        
        LazyVStack(alignment: .leading, spacing: 16) {
            ForEach(vm.recognizedItems.indices, id: \.self) { index in
                let item = vm.recognizedItems[index]
                switch item {
                case .barcode(let barcode):
                    Text("Item Found!")
                        .onAppear {
                            if let tempBarcode = barcode.payloadStringValue {
                                foundBarcode = tempBarcode
                                print(foundBarcode)
                                isShowingItemFoundView = true
                            }
                        }
                    
                case .text(let text):
                    Text(text.transcript)
                @unknown default:
                    Text("Unknown")
                }
            }
        }
        
    
    
    }
    func showToast(_ message: String) {
            toastMessage = message
            showToast = true
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
