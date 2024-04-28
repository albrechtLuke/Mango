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
                Text("Your device does not have a camera")
                    .fullScreenCover(isPresented: .constant(true), content: {
                        PermissionView(permissionImage: "questionmark.video", permissionText: "Your device does not have a camera")
                    })
            }
        }
    }
    
    private var headerView: some View {
        VStack {
            Text(vm.headerText)
                .padding(.top)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
    
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
    
    
    private var bottomContainerView: some View {
        VStack {
            headerView
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(vm.recognizedItems.indices, id: \.self) { index in
                        let item = vm.recognizedItems[index]
                        switch item {
                        case .barcode(let barcode):
                            let tempBarcode = barcode.payloadStringValue ?? "Unknown Barcode"
                            Text("Item Found!")
                                .onAppear(perform: {
                                    isShowingItemFoundView = true // Set isShowingItemFoundView to true here
                                    while foundBarcode == nil {
                                        foundBarcode = tempBarcode
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
                    ItemFoundView(isPresented: $isShowingItemFoundView, foundBarcode: $foundBarcode, barcodeID: foundBarcode ?? "")
                }
            }
        }
        
    }
}


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

struct ItemFoundView: View {
    @Binding var isPresented: Bool
    @Binding var foundBarcode: String?
    let barcodeID: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(barcodeID)
                    .font(.title)
                    .fontWeight(.heavy)
                
                NavigationLink(destination: TESTItemSecondView(isPresented: $isPresented, foundBarcode: $foundBarcode, barcodeID: barcodeID)) {
                    Text("Go to Second View")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
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
    }
}

struct TESTItemSecondView: View {
    @Binding var isPresented: Bool
    @Binding var foundBarcode: String?
    let barcodeID: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Second test view")
                Text(barcodeID)
                    .font(.title)
                    .fontWeight(.heavy)
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
}

