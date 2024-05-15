//
//  DummyAddView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 15/5/2024.
//

import SwiftUI

struct DummyAddView: View {
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            Text("Tap to add item")
            Button("Add item") {
                addItem()
            }
        }
    }
    
    func addItem() {
        //Create item
        
        let item = SavedItems(barcodeID: 4, name: "TEST", status: true, image: "nate")
        //Add item to data context
        context.insert(item)
    }
    
}

#Preview {
    DummyAddView()
}
