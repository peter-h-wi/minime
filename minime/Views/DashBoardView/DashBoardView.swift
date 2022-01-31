//
//  ContentView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI
import UniformTypeIdentifiers
import LocalAuthentication

struct DashBoardView: View {
    @State private var isUnlocked = false
    @State private var isSearching = false
    @StateObject var DashBoardVM = DashBoardViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    let colors : [Color] = [.mint, .pink, .purple, .blue, .brown, .cyan, .indigo, .green, .orange, .teal, .secondary]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBar(text: $DashBoardVM.searchText, isSearching: $isSearching)
                        .padding(.vertical, 5)
                    Divider()
                        .padding(.top, 11)
                    if (isSearching) {
                        Text("Search Results")
                            .font(Font.title3.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(DashBoardVM.getFilteredDocs(), id: \.id) { doc in
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
                                    NavigationLink(destination: DocView(doc: doc)) {
                                        Text(doc.title)
                                            .font(Font.title3.weight(.semibold))
                                            .multilineTextAlignment(.leading)
                                            .frame(width: 134, height: 50, alignment: .bottomLeading)
                                    }
                                }
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                .fill(colors[doc.colorIndex]))
                                .contentShape(Rectangle())
                                .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue:0/255).opacity(0.25), radius: 8, x: 0, y: 4)
                                .onDrag({
                                    DashBoardVM.draggedItem = doc
                                    return NSItemProvider(item: nil, typeIdentifier: nil)
                                })
                                .onDrop(of: [UTType.text], delegate: MyDropDelegate(item: doc, items: $DashBoardVM.docs, draggedItem: $DashBoardVM.draggedItem))
                            }
                        }
                        .frame(minHeight: 100)
                    } else {
                        Text("Favorite")
                            .font(Font.title3.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(DashBoardVM.getFavoriteDocs(), id: \.id) { doc in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Button(action: {
                                            withAnimation{
                                                DashBoardVM.toggleFavoriteOf(doc)
                                                DashBoardVM.fetchAllDocs()
                                            }
                                        }) {
                                            Image(systemName: "heart.fill")
                                                .font(Font.title2.weight(.semibold))
                                                .foregroundColor(.yellow)
                                        }
                                        Spacer()
                                        DeleteButton(DashBoardVM: DashBoardVM, doc: doc)
                                    }
                                    NavigationLink(destination: DocView(doc: doc)) {
                                        Text(doc.title)
                                            .font(Font.title3.weight(.semibold))
                                            .multilineTextAlignment(.leading)
                                            .frame(width: 134, height: 50, alignment: .bottomLeading)
                                    }
                                }
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                .fill(colors[doc.colorIndex]))
                                .contentShape(Rectangle())
                                .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue:0/255).opacity(0.25), radius: 8, x: 0, y: 4)
                                .onDrag({
                                    DashBoardVM.draggedItem = doc
                                    return NSItemProvider(item: nil, typeIdentifier: nil)
                                })
                                .onDrop(of: [UTType.text], delegate: MyDropDelegate(item: doc, items: $DashBoardVM.docs, draggedItem: $DashBoardVM.draggedItem))
                            }
                        }
                        .frame(minHeight: 100)
                        Divider()
                            .padding(.top, 11)
                        
                        Text("All")
                            .font(Font.title3.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(DashBoardVM.getAllDocs(), id: \.id) { doc in
                                NavigationLink(destination: DocView(doc: doc)) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Button(action: {
                                                withAnimation{
                                                    DashBoardVM.toggleFavoriteOf(doc)
                                                    DashBoardVM.fetchAllDocs()
                                                }
                                            }) {
                                                Image(systemName: "heart")
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
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                    .fill(colors[doc.colorIndex]))
                                    .contentShape(Rectangle())
                                    .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue:0/255).opacity(0.25), radius: 8, x: 0, y: 4)
                                }
                            }
                        }
                        .frame(minHeight: 100)
                    }
                }
            }
            .navigationBarTitle("Minime")
            .navigationBarItems(trailing: NavigationLink(destination: AddDocView(DashBoardVM: DashBoardVM)) {
                Image(systemName: "plus")
            })
            .navigationBarItems(trailing: EditButton())
        }
        .disabled(!isUnlocked)
        .blur(radius: isUnlocked ? 0 : 10)
        .opacity(isUnlocked ? 1 : 0.6)
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.05))
        .onAppear(perform: {
            DashBoardVM.fetchAllDocs()
            authenticate()
        })
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                } else {
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct DeleteButton: View {
    @Environment(\.editMode) var editMode
    @StateObject var DashBoardVM: DashBoardViewModel
    let doc: DocViewModel
    
    var body: some View {
        if self.editMode?.wrappedValue == .active {
            Button(action: {
                withAnimation {
                    DashBoardVM.delete(doc)
                    DashBoardVM.fetchAllDocs()
                }
            }) {
                Image(systemName: "x.circle.fill")
                    .font(Font.title2.weight(.semibold))
                    .foregroundColor(.red)
            }
        }
    }
}


struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
        
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
                        
                        if isSearching {
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
                        self.isSearching = true
                    }
                }
            
            if isSearching {
                Button(action: {
                    withAnimation {
                        self.isSearching = false
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
        .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue:0/255).opacity(0.25), radius: 8, x: 0, y: 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}

struct MyDropDelegate: DropDelegate {
    let item : DocViewModel
    @StateObject var vm = DashBoardViewModel()
    @Binding var items : [DocViewModel]
    @Binding var draggedItem : DocViewModel?
    
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedItem = draggedItem else {
            return
        }

        if draggedItem.id != item.id {
            let from = items.firstIndex(where: {$0.id == draggedItem.id})!
            let to = items.firstIndex(where: {$0.id == item.id})!
            withAnimation(.default) {
                self.items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
            }
            vm.changeLocation()
        }
    }
}
