//
//  TitlePageView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 21/6/2024.
//

import SwiftUI



struct TitlePageView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?

    
    var body: some View {
        NavigationStack {
            
            ZStack {
                VStack {
                    
                    Text("Welcome to Mango")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .padding(.top, 110)
                    Text("🥭")
                        .font(.system(size: 300))
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    
                    NavigationLink(destination: InedIngSelectView()) {
                        HStack(spacing: 8) {
                            Text("Start")
                                .bold()
                            
                            Image(systemName: "arrow.right.circle")
                                .imageScale(.large)
                                .bold()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                }
            }
        }
    }
}

#Preview {
    TitlePageView()
}
