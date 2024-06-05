//
//  ReusableListView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 27/5/2024.
//

import SwiftUI

struct ListItem: Identifiable {
    var id = UUID()
    var name: String
    var ConsumableColor: Bool?
    var indent: Bool
    
}

struct ReusableListView: View {
    
    @State var listItems: [ListItem]
    @State var sectionHeader: String?
    
    var body: some View {
        List {
            Section(header: Text(sectionHeader ?? "")) {
                ForEach(listItems.indices, id: \.self) { index in
                    HStack {
                        //indents item if is required
                        if listItems[index].indent == true {
                            Rectangle()
                                .frame(width: 20)
                                .foregroundStyle(.clear)
                        }
                        
                        Button(action: {}){
                            // Change the item color based on consumability
                            HStack {
                                Text(listItems[index].name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 4)
                                    .padding()
                                    .background(listItems[index].ConsumableColor == true ? Color.green : Color.clear)
                                    .background(listItems[index].ConsumableColor == false ? Color.red : Color.clear)
                                    .cornerRadius(10)
                                    .fontWeight(.semibold)
                            }
                            .contentShape(Rectangle())
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle()) // Removes the button highlighting
            .listRowBackground(Color.lightGrey) //fixes button background
            
            
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ReusableListView(listItems: [ListItem(name: "1", indent: false),
                                 ListItem(name: "2", ConsumableColor: true, indent: false),
                                 ListItem(name: "3", ConsumableColor: false, indent: false),
                                 ListItem(name: "4", indent: false)], sectionHeader: "Test SectionHeader")
}
