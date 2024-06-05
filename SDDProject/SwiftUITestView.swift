//
//  SwiftUITestView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 27/4/2024.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct SwiftUITestView: View {
    @State var isModalSheetShown: Bool = false
    
    var body: some View {
        VStack {
            Text("Main")
        }
        .navigationBarItems(trailing: Button("Add", action: { self.isModalSheetShown.toggle() }))
        .sheet(isPresented: $isModalSheetShown) {
            NavigationStack {
                VStack {
                    Text("Modal")
                }
//                .navigationBarItems(trailing: Button("Done") {
//                    isModalSheetShown.toggle()
//                })
                .navigationBarItems(trailing: Button(action: {
    //                                foundBarcode = nil
    //                                isPresented = false
                                    
                                }) {
                                    Image(systemName: "x.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .padding(.top)
                                })

                
            }
            
            .presentationDetents([.large, .fraction(0.5)])
            .presentationCornerRadius(30)
            .presentationDragIndicator(.visible)
            .interactiveDismissDisabled()
        }
        
    }
}

#Preview {
    NavigationStack {
        SwiftUITestView()
    }
}
