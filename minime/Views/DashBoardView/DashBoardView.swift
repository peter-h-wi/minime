//
//  ContentView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI

struct DashBoardView: View {
    
    @StateObject private var viewModel = DashBoardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBar(text: $viewModel.searchText)
                        .padding(.vertical, 5)
                    Text("Favorite")
                        .font(Font.title3.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    DocButtonListView(docListVM: viewModel.favDocList)
                    Text("All")
                        .font(Font.title3.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    DocButtonListView(docListVM: viewModel.allDocList)
                }
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.05))
            }
            .navigationBarTitle("All Documents")
            .navigationBarItems(trailing: HStack {
                NavigationLink(destination: AddDocView()) {
                    Image(systemName: "plus")
                }
            })
//            ScrollView {
//                VStack {
//                    SearchBar(text: $viewModel.searchText)
//                        .padding(.vertical, 5)
//                    Text("Favorite")
//                        .font(Font.title3.weight(.semibold))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding()
//                    FavoriteDocView(viewModel: viewModel, colors: colors)
//                    Text("All")
//                        .font(Font.title3.weight(.semibold))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding()
//                    AllDocView(viewModel: viewModel, colors: colors)
//                }
//                .frame(maxWidth: .infinity)
//                .background(Color.gray.opacity(0.05))
//            }
//            .navigationBarTitle("All documents")
//            .navigationBarItems(trailing: HStack {
//                NavigationLink(destination: AddDocView()) {
//                    Image(systemName: "plus")
//                }
//            })
            
        }
    }
}

struct DocumentButton: View {
    let doc: DocInfo
    let buttonColor: Color
    
    @State private var something = 1
    var body: some View {
        NavigationLink(destination: DocView()) {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        //doc.favorite.toggle()
                    }) {
                        Image(systemName: doc.favorite ? "heart.fill" : "heart")
                            .font(Font.title2.weight(.semibold))
                            .foregroundColor(.yellow)
                    }
                    Spacer()
                    NavigationLink(destination: DocSettingView()) {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(Font.title2.weight(.semibold))
                    }
                }
                Text(doc.title)
                    .font(Font.title3.weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .frame(width: 134, height: 50, alignment: .bottomLeading)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(buttonColor))
            
            .contentShape(Rectangle())
        }
        
    }
}

struct SearchBar: View {
    @Binding var text: String

        @State private var isEditing = false
            
        var body: some View {
            HStack {
                
                TextField("Search", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 7)
                            
                            if isEditing {
                                Button(action: {
                                    self.text = ""
                                    
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 16)
                    .onTapGesture {
                        withAnimation {
                            self.isEditing = true
                        }
                    }
                
                if isEditing {
                    Button(action: {
                        withAnimation {
                            self.isEditing = false
                        }
                        self.text = ""
                        
                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}

struct FavoriteDocView: View {
    @StateObject var viewModel: DashBoardViewModel
    let colors: [Color]
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
//            ForEach(viewModel.favDocInfos, id:\.id) { doc in
//                DocumentButton(isFavorite: true, doc: doc, buttonColor: colors[(doc.id * 7 + 5) % 11])
//                    .padding(.horizontal)
//            }
        }
    }
}

struct AllDocView: View {
    @StateObject var viewModel: DashBoardViewModel
    let colors: [Color]
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
//            ForEach(viewModel.docInfos, id:\.id) { doc in
//                DocumentButton(isFavorite: false, doc: doc, buttonColor: colors[(doc.id * 5 + 7) % 11])
//                    .padding(.horizontal)
//            }
        }
    }
}
