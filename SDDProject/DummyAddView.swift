//
//  DummyAddView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 15/5/2024.
//

import SwiftUI

struct DummyAddView: View {
    
    @State var item = SavedItems(barcodeID: 0, name: "", status: false, image: "")
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
        item.barcodeID = 4
        item.name = "TEST"
        item.status = true
        item.image = "nate"

        //Add item to data context
        context.insert(item)
    }
    
}

#Preview {
    DummyAddView()
}
