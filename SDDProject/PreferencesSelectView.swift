//
//  PreferencesSelectView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 2/6/2024.
//

import SwiftUI

struct PreferencesSelectView: View {
    @State var listItems: [ListItem]
    var body: some View {
        NavigationStack {
            ReusableListView(listItems: listItems)
                
                .navigationTitle("Select Preference(s)")
                //Makes multi-line titles possible
//                .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .principal) {
//                                HStack {
//                                    Text("Select Dietary Preferences(s)")
//                                        
//                                        .font(.largeTitle)
//                                        .bold()
//                                        .multilineTextAlignment(.leading)
//                                        .fixedSize(horizontal: false, vertical: true)
//                                        .padding(.top, 50)
//                                        
//                                        
//                                    Spacer()
//                                }
//                                
//                            }
//                            
//                            
//                        }
        }
    }
}

#Preview {
    PreferencesSelectView(listItems: [ListItem(name: "item1", indent: false), ListItem(name: "item2", indent: false), ])
}
