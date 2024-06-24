//
//  OnboardingView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 21/6/2024.
//

import SwiftUI

struct OnboardingView: View {
    
        @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
        
    
        var body: some View {
            ZStack {
               
                
                VStack {
                    Spacer()
                    Button(action: {
                            isOnboarding = false
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }) {
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
//          .accentColor(Color.white)
        }
    }






#Preview {
    OnboardingView()
}
