//
//  SwiftUITestView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 27/4/2024.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct SwiftUITestView: View {
    @State var myVar: Bool
    var body: some View {
        NavigationStack {
            
            Button {
                myVar.toggle()
            } label: {
                Text("NextView")
            }
            .buttonStyle(.borderedProminent)
            
        }
    }
}

#Preview {
    NavigationStack {
        SwiftUITestView(myVar: false)
    }
}
 
