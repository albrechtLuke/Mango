//
//  DummyListView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 15/5/2024.
//

import SwiftUI
import SwiftData


struct DummyListView: View {
    
    //Call SwiftData Container
    @Environment(\.modelContext) private var context
    @Query private var items: [SavedItems]
    
    var body: some View {
        NavigationView {
            List {
                //displays each item from SwiftData container in a list view
                ForEach(items) { item in
                    ListRow(imageName: item.image, heading: item.name, subtitle: "Subtitle")
                }
            }
            .navigationTitle("Past Scans")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: DummyAddView()) {
                        Image(systemName: "gearshape")
                            .bold()
                    }
                }
            }
        }
    }

}

//Struct for the individual row items.
struct ListRow: View {
    let imageName: String
    let heading: String
    let subtitle: String
    
    var body: some View {
        HStack {
    
            Text("")
                .frame(maxWidth: 0)
            
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            VStack(alignment: .leading) {
                Text(heading)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        
    }
}
