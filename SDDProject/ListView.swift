//
//  ListView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 15/5/2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    @State private var showToast = false
    @State private var items: [SavedItems] = []
    
    //Call SwiftData Container
    @Environment(\.modelContext) private var context
    @Query private var queryItems: [SavedItems]
    
    var body: some View {
        NavigationView {
            List {
                //displays each item from SwiftData container in a list view
                ForEach(items) { item in
//                    NavigationLink("hello", destination: ApiResponseView(isPresented: <#T##Binding<Bool>#>, barcodeID: <#T##String#>, showErrorToast: <#T##(String) -> Void#>))
                    
                    ListRow(imageName: item.image, heading: item.name, status: item.status)
                }
                .onDelete(perform: deleteItems)
            }
            .onAppear {
                refreshItems()
            }
            .navigationTitle("Past Scans")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: InedIngSelectView()) {
                        Image(systemName: "gearshape")
                            .bold()
                    }
                }
            }
        }
    }
    
    private func refreshItems() {
        // Refresh the data from the queryItems
        items = queryItems
    }
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            context.delete(item)
        }
        do {
            try context.save()
            refreshItems()
        } catch {
            // Handle the error appropriately
        }
    }
}

//Struct for the individual row items.
struct ListRow: View {
    let imageName: String
    let heading: String
    let status: Bool
    
    var body: some View {
        HStack {
    
            Text("")
                .frame(maxWidth: 0)
            
            AsyncImage(url: URL(string: imageName)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
            } placeholder: {
                Color.gray
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 50, height: 50)
            }
            
                
                
            VStack(alignment: .leading) {
                Text(heading.capitalized)
                Text(status ? "good" : "bad")
                    .font(.subheadline)
                    .foregroundColor(status ? .green : .red)
            }
        }
        
    }
}
