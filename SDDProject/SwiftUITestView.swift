//
//  SwiftUITestView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 27/4/2024.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct SwiftUITestView: View {
    @State private var isLoading = false
     
        var body: some View {
            LoadingIndicator(size: .large)
                
            
        }
    
}

#Preview {
    SwiftUITestView()
}
