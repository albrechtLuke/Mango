//
//  DummyAddView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 15/5/2024.
//

import SwiftUI

struct DummyAddView: View {
    
    @State var item = SavedItems(foundBarcode: 0, name: "", status: false, image: "")
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            Text("Tap to add item")
            Button("Add item") {
                addItem(foundBarcode: 4,name:"Test",status:false,image:"nate")
            }
        }
    }
    
    func addItem(foundBarcode: Int, name: String, status: Bool, image: String) {
        //Create item
        item.foundBarcode = foundBarcode
        item.name = name
        item.status = status
        item.image = image

        //Add item to data context
        context.insert(item)
    }

    
        
}
