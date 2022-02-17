//
//  ContentView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct DashBoardView: View {
    @State private var isSearching = false
    @StateObject var DashBoardVM = DashBoardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBarView(text: $DashBoardVM.searchText, isSearching: $isSearching)
                        .padding(.vertical, 5)
                    Divider()
                        .padding(.top, 11)
                    if (isSearching) {
                        Text("Search Results")
                            .font(Font.title3.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        DocListView(DashBoardVM: DashBoardVM, docListType: .search)
                    }
                    else {
                        Text("Favorite")
                            .font(Font.title3.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        DocListView(DashBoardVM: DashBoardVM, docListType: .favorite)
                        Divider()
                            .padding(.top, 11)
                        
                        Text("All")
                            .font(Font.title3.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        DocListView(DashBoardVM: DashBoardVM, docListType: .normal)
                    }
                }
            }
            .navigationBarTitle("DocuVault")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem (placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddDocView(DashBoardVM: DashBoardVM)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear(perform: {
            DashBoardVM.fetchAllDocs()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
            .preferredColorScheme(.light)
        DashBoardView()
            .preferredColorScheme(.dark)
    }
}
