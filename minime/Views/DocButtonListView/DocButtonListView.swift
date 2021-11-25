//
//  DocButtonListView.swift
//  minime
//
//  Created by peter wi on 11/25/21.
//

import SwiftUI

struct DocButtonListView: View {
    @ObservedObject var docListVM: DocButtonListViewModel = DocButtonListViewModel([DocButtonViewModel(DocInfo(favorite: true, title: "test image", images: nil)), DocButtonViewModel(DocInfo(favorite: true, title: "test image", images: nil))])
    let colors : [Color] = [.mint, .pink, .purple, .blue, .brown, .cyan, .indigo, .green, .orange, .teal, .secondary]
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(self.docListVM.docVMList ?? [DocButtonViewModel(DocInfo(favorite: true, title: "test image", images: nil))], id: \.id) { docVM in
                DocButtonView(docVM: docVM, buttonColor: colors[docVM.docInfo.id.hashValue % 11])
                    .padding(.horizontal)
            }
        }
    }
}

struct DocButtonListView_Previews: PreviewProvider {
    static var previews: some View {
        DocButtonListView()
    }
}
