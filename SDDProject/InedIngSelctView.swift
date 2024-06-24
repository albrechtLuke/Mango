//
//  PreferencesSelectView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 2/6/2024.
//

import SwiftUI

struct InedIngSelectView: View {
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        ZStack {
            List {
                ForEach(vm.preferences.keys.sorted(), id: \.self) { category in
                    HStack {
                        Button(action: {
                            vm.togglePreference(category)
                        }) {
                            HStack {
                                Text(category)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 4)
                                    .padding()
                                    .background(vm.selectedPreferences.contains(category) ? Color.accentColor : Color.clear)
                                    .cornerRadius(10)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(vm.selectedPreferences.contains(category) ? .white : .primary)
                            }
                            .contentShape(Rectangle())
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // Removes the button highlighting
                    .listRowBackground(Color.lightGrey) // Fixes button background
                }
            }
            .navigationTitle("Preferences")
            
            if vm.isOnboarding {
                VStack {
                    Spacer()
                    Button {
                        vm.finishOnboarding()
                    } label: {
                        HStack(spacing: 8) {
                            Text("Finish")
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
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    InedIngSelectView()
}


