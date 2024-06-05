//
//  DummyResultsView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 18/5/2024.
//
// i firgot o]how this works
import SwiftUI

struct DummyResultsView: View {
    
    @State var listItems: [ListItem]
    @State var itemTitle: String
    @State var itemImage: String
    @Binding var isPresented: Bool
    @Binding var foundBarcode: String?
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { geometry in
                    AsyncImage(url: URL(string: itemImage)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .frame(width: geometry.size.width)
                        
                            .clipped() // Ensures the image doesn't overflow
                            
                    } placeholder: {
                        Color.red
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    
                    .padding(.vertical)
                }
                .frame(height: 400) // Set the desired height of the image
                
                Spacer()
                
                // Presents Sheet
                .sheet(isPresented: .constant(true), content: {
                    ResultSheetView(listItems: listItems, itemTitle: itemTitle, isPresented: $isPresented, foundBarcode: $foundBarcode)
                        .presentationDetents([.large, .fraction(0.5)])
                        .presentationCornerRadius(30)
                        .presentationDragIndicator(.visible)
                        .interactiveDismissDisabled()
                        
                })
            }
        }
    }
}

struct ResultSheetView: View {
    
    @State var listItems: [ListItem]
    @State var itemTitle: String
    @Binding var isPresented: Bool
    @Binding var foundBarcode: String?
    
    var body: some View {
        NavigationStack {
            HStack {
                Text(itemTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                    .padding(.horizontal, 30)
                .padding(.bottom, -10)
                Button(action: {
                    foundBarcode = nil
                    isPresented = false
                    
                                }) {
                                    Image(systemName: "x.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                        .padding()
                                        .font(Font.title.weight(.bold))
                                    
                                }
            }
            
            // Reusable code for list
            ReusableListView(listItems: listItems, sectionHeader: "Ingredients Breakdown")
            
        }
    }
}

//#Preview {
//    DummyResultsView(listItems:  [
//        ListItem(name: "item1", ConsumableColor: false, indent: false),
//        ListItem(name: "item2", ConsumableColor: true, indent: false),
//        ListItem(name: "item3", ConsumableColor: nil, indent: false),
//        ListItem(name: "item4", ConsumableColor: true, indent: false),
//        ListItem(name: "item5", ConsumableColor: true, indent: true),
//        ListItem(name: "item6", ConsumableColor: true, indent: true),
//        ListItem(name: "item7", ConsumableColor: false, indent: false)], itemTitle: "TEST", itemImage: "https://images.openfoodfacts.org/images/products/931/382/001/6108/front_en.25.400.jpg", isPresented: true)
//}
