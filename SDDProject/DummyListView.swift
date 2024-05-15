//
//  DummyListView.swift
//  SDDProject
//
//  Created by Luke Albrecht on 15/5/2024.
//

import SwiftUI



struct DummyListView: View {
    
    var body: some View {
        NavigationStack {
            List {
                
                ListRow(imageName: "nate", heading: "Heading", subtitle: "Subtitle")
                ListRow(imageName: "nate", heading: "Heading", subtitle: "Subtitle")
                ListRow(imageName: "nate", heading: "Heading", subtitle: "Subtitle")
                ListRow(imageName: "nate", heading: "Heading", subtitle: "Subtitle")
                
            }
            .navigationTitle("Past Scans")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape")
                            .bold()
                    }
                
            }
//                Image(systemName: "gearshape")
//                Button("Help") {
//                    print("Help tapped!")
//                }
            }
            
        }
    }
}

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

#Preview {
    DummyListView()
}
