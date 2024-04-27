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
    
//    
//    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
//        ("ALL", .none),
//        ("URL", .URL),
//        ("Phone", .telephoneNumber),
//        ("Email", .emailAddress),
//        ("Address", .fullStreetAddress)]
    
    var body: some View {
        
        switch vm.dataScannerAccessStatus {
        case .notDetermined:
            PermissionView(permissionImage: "video", permissionText: "Requesting Camera Access")
        case .cameraAccessNotGranted:
            PermissionView(permissionImage: "video.slash", permissionText: "Please provide access to the camera in settings")
        case .cameraNotAvailable:
            PermissionView(permissionImage: "video.slash", permissionText: "Your device does not have support for scanning barcode with this app!")
        case .scannerAvailable:
            mainView
        case .scannerNotAvailable:
            PermissionView(permissionImage: "questionmark.video", permissionText: "Your device does not have a camera")
        }
        
    }
    
    private var headerView: some View {
        VStack {
            //showing commit changes
//            HStack {
//                Picker("Scan Type", selection: $vm.scanType) {
//                    Text("Barcode").tag(ScanType.barcode)
//                    Text("Text").tag(ScanType.text)
//                }
//                .pickerStyle(.segmented)
                
//                Toggle("Scan multple", isOn: $vm.recognizesMultipleItems)
//            }
//            .padding(.top)
            
//            if vm.scanType == .text {
//                Picker("Text content type", selection: $vm.textContentType) {
//                    ForEach(textContentTypes, id: \.self.textContentType) { option in
//                        Text(option.title).tag(option.textContentType)
//                    }
//                }
//                .pickerStyle(.segmented)
//            }
            
            Text(vm.headerText)
                .padding(.top)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding(.horizontal )
    }
    
    private var mainView: some View {
        TabView {
            Group {
                
                
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
                
                
                
                //            .sheet(isPresented: .constant(true), content: {
                //                bottomContainerView
                //                    .background(.ultraThinMaterial)
                //                    .presentationDetents([.medium, .fraction(0.25)])
                //                    .presentationDragIndicator(.visible)
                //                    .interactiveDismissDisabled()
                //                //makes sheet translucent
                //                    .onAppear {
                //                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                //                              let controller = windowScene.windows.first?.rootViewController?.presentedViewController else {
                //                            return
                //                        }
                //                        controller.view.backgroundColor = .clear
                //                    }
                //            })
                
            }
//            .toolbarBackground(.blue, for: .tabBar)
//            .toolbarBackground(.visible, for: .tabBar)
//            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
    
    
    private var bottomContainerView: some View {
        VStack {
            headerView
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(vm.recognizedItems) { item in
                        switch item {
                        case .barcode(let barcode):
                            Text(barcode.payloadStringValue ?? "Unknown Barcode")
                            
                            
                        case .text(let text):
                            Text(text.transcript)
                            
                        @unknown default:
                            Text("Unknown")
                            
                        }
                    }
                }
                .padding()
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
