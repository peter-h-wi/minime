//
//  DocListView.swift
//  minime
//
//  Created by peter wi on 2/17/22.
//

import SwiftUI


enum DocListType {
    case search, favorite, normal
}

struct DocListView: View {
    @ObservedObject var DashBoardVM: DashBoardViewModel
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    let docListType: DocListType
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            if (docListType == .search) {
                ForEach(DashBoardVM.getFilteredDocs(), id: \.id) { doc in
                    NavigationCardView(doc: doc, DashBoardVM: DashBoardVM)
                }
            } else if (docListType == .favorite) {
                ForEach(DashBoardVM.getFavoriteDocs(), id: \.id) { doc in
                    NavigationCardView(doc: doc, DashBoardVM: DashBoardVM)
                }
            } else {
                ForEach(DashBoardVM.getAllDocs(), id: \.id) { doc in
                    NavigationCardView(doc: doc, DashBoardVM: DashBoardVM)
                }
            }
        }
        .frame(minHeight: 100)
    }
}
