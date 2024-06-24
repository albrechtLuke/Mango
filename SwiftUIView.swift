//
//  SwiftUIView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 5/6/2024.
//

import AlertToast
import SwiftUI

struct NextView: View{

    @State private var showToast = false

    var body: some View{
        VStack{

            Button("Show Toast"){
                 showToast.toggle()
            }
        }
        .toast(isPresenting: $showToast){
            AlertToast(displayMode: .hud, type: .systemImage("exclamationmark.triangle.fill", .red), title: "No internet!")
        }
    }
}

#Preview {
    NextView()
}
