//
//  ContentView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI

struct DashBoardView: View {
    
    @EnvironmentObject private var DashBoardVM : DashBoardViewModel
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    let colors : [Color] = [.mint, .pink, .purple, .blue, .brown, .cyan, .indigo, .green, .orange, .teal, .secondary]

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBar(text: $DashBoardVM.searchText)
                        .padding(.vertical, 5)
                    Text("Favorite")
                        .font(Font.title3.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(DashBoardVM.favDocs, id: \.id) { doc in
                            NavigationLink(destination: DocView()) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "heart.fill")
                                            .font(Font.title2.weight(.semibold))
                                            .foregroundColor(.yellow)
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
                                .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                .fill(colors[doc.colorIndex]))
                                .contentShape(Rectangle())
                            }
                        }
                    }
                    
                    Text("All")
                        .font(Font.title3.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(DashBoardVM.allDocs, id: \.id) { doc in
                            NavigationLink(destination: DocView()) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "heart")
                                            .font(Font.title2.weight(.semibold))
                                            .foregroundColor(.yellow)
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
                                .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                .fill(colors[doc.colorIndex]))
                                .contentShape(Rectangle())
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.05))
            }
            .navigationBarTitle("All Documents")
            .navigationBarItems(trailing: NavigationLink(destination: AddDocView()) {
                Image(systemName: "plus")
            })
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
