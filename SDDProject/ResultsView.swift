//
//  ResultsView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 18/5/2024.
//
//
import SwiftUI

struct ResultsView: View {
    
    @State var listItems: [ListItem]
    @State var itemTitle: String
    @State var itemImage: String
    @State var preferenceMatch: [String?]
    @Binding var isPresented: Bool
//    @Binding var foundBarcode: String?
    
    var allPreferencesMatched: Bool {
        preferenceMatch.allSatisfy { $0 == nil }
    }
    
    var body: some View {
        ZStack {
            
            AsyncImage(url: URL(string: itemImage)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .clipped()
                    .blur(radius: 20)
                    .frame(height: 700)
            } placeholder: {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.lightGrey)
                    .blur(radius: 20)
            }
            
            Group {
                VStack {
                    GeometryReader { geometry in
                        AsyncImage(url: URL(string: itemImage)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .frame(width: geometry.size.width)
                                .clipped()
                        } placeholder: {
                            Color.gray
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                        .padding(.vertical)
                    }
                    .frame(height: 370)
                    
                    Spacer()
                    
                    //                 Presents Sheet
                        .sheet(isPresented: $isPresented, content: {
                            ResultSheetView(listItems: listItems, itemTitle: itemTitle, preferenceMatch: preferenceMatch, isPresented: $isPresented)
                                .presentationDetents([.large, .fraction(0.5)]/*, largestUndimmed: .constant(4)*/)
                                .presentationCornerRadius(30)
                                .presentationDragIndicator(.visible)
                                .interactiveDismissDisabled()
                                .presentationBackgroundInteraction(.enabled(upThrough: .medium))

//                                .presentationDetents([.medium])
                        })
                }
                
                
                //Overlay Checkmark/
                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 55, height: 55)
                                .foregroundStyle(.white)
                            if allPreferencesMatched {
                                Image(systemName: "checkmark.seal.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.green)
                                    .padding()
                            } else {
                                
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.red)
                                    .padding()
                            }
                            
                            
                        }
                        
                    }
                    Spacer()
                }
                
            }
            .padding(.top, 10)


        }
    }
}

struct ResultSheetView: View {
    
    @State var listItems: [ListItem]
    @State var itemTitle: String
    @State var preferenceMatch: [String?]
    @Binding var isPresented: Bool
//    @State var foundBarcode: String
    
    var fullTitle: String {
        let uniquePreferences = Array(Set(preferenceMatch.compactMap { $0 }))
        let preferencesString = uniquePreferences.map { "is not \($0)" }.joined(separator: " and not")
        return "\(itemTitle) \(preferencesString)"
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                Text(fullTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                    .padding(.leading, 30)
                    .padding(.bottom, -10)
                    
                VStack {
                    Button(action: {
//                        foundBarcode = nil
                        isPresented = false
                    }) {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .padding(.trailing)
                            .font(.title.weight(.bold))
                    }
                    
                    
                }
                
            }
            
            
            // Reusable code for list
            ReusableListView(listItems: listItems, sectionHeader: "Ingredients Breakdown")
        }
    }
    
}

struct ReusableListView: View {
    
    @State var listItems: [ListItem]
    @State var sectionHeader: String?
    
    var body: some View {
        List {
            Section(header: Text(sectionHeader ?? "")) {
                ForEach(listItems.indices, id: \.self) { index in
                    HStack {
                        // Indents item if required
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
                                    .background(listItems[index].ConsumableColor == true ? Color.red : Color.clear)
                                    .background(listItems[index].ConsumableColor == false ? Color.green : Color.clear)
                                    .cornerRadius(10)
                                    .fontWeight(.semibold)
                            }
                            .contentShape(Rectangle())
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle()) // Removes the button highlighting
            .listRowBackground(Color.lightGrey) // Fixes button background
        }
        .scrollContentBackground(.hidden)
    }
}
    
