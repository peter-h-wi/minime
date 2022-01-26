//
//  ContentView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI
import LocalAuthentication

struct DashBoardView: View {
    @State private var isUnlocked = false
    @StateObject var DashBoardVM = DashBoardViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    let colors : [Color] = [.mint, .pink, .purple, .blue, .brown, .cyan, .indigo, .green, .orange, .teal, .secondary]
    
    var body: some View {
        NavigationView {
            if isUnlocked {
                ScrollView {
                    VStack {
                        SearchBar(text: $DashBoardVM.searchText)
                            .padding(.vertical, 5)
                        Divider()
                            .padding(.top, 11)
                        
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
                .navigationBarTitle("DocuVault")
                .navigationBarItems(trailing: NavigationLink(destination: AddDocView(DashBoardVM: DashBoardVM)) {
                    Image(systemName: "plus")
                })
            .navigationBarItems(trailing: EditButton())
            } else {
                Text("Locked")
            }
        }
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.05))
        .onAppear(perform: {
            authenticate()
            DashBoardVM.fetchAllDocs()
        })
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
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
    
//
//    @Binding var numbers: [Int]
//    let onDelete: (IndexSet) -> ()
//
//    var body: some View {
//        VStack {
//            if self.editMode?.wrappedValue == .active {
//                Button(action: {
//                    if let index = numbers.firstIndex(of: number) {
//                        self.onDelete(IndexSet(integer: index))
//                    }
//                }) {
//                    Image(systemName: "minus.circle")
//                }
//                .offset(x: 10, y: -10)
//            }
//        }
//    }
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
        .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue:0/255).opacity(0.25), radius: 8, x: 0, y: 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}
