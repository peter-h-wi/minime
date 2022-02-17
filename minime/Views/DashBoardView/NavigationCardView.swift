//
//  NavigationCardView.swift
//  minime
//
//  Created by peter wi on 2/17/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct NavigationCardView: View {
    let doc: DocViewModel
    let colors : [Color] = [.mint, .pink, .purple, .blue, .brown, .cyan, .indigo, .green, .orange, .teal, .secondary]
    @ObservedObject var DashBoardVM: DashBoardViewModel
    
    var body: some View {
        NavigationLink(destination: DocView(doc: doc)) {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        withAnimation{
                            DashBoardVM.toggleFavoriteOf(doc)
                            DashBoardVM.fetchAllDocs()
                        }
                    }) {
                        Image(systemName: doc.favorite ? "heart.fill" : "heart")
                            .font(Font.title2.weight(.semibold))
                            .foregroundColor(.yellow)
                    }
                    Spacer()
                    DeleteButton(DashBoardVM: DashBoardVM, doc: doc)
                }
                Text(doc.title)
                    .font(Font.title3.weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .frame(width: 134, height: 50, alignment: .bottomLeading)
            }
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .strokeBorder(colors[doc.colorIndex], lineWidth: 3)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(colors[doc.colorIndex])
                        .opacity(0.5)
                )
        )
        
        .contentShape(Rectangle())
        .shadow(color: colors[doc.colorIndex].opacity(0.8), radius: 6, x: 0, y: 4)
        .onDrag({
            DashBoardVM.draggedItem = doc
            return NSItemProvider(item: nil, typeIdentifier: nil)
        })
        .onDrop(of: [UTType.text], delegate: MyDropDelegate(item: doc, vm: DashBoardVM, items: $DashBoardVM.docs, draggedItem: $DashBoardVM.draggedItem))
    }
}
