//
//  SearchBarView.swift
//  minime
//
//  Created by peter wi on 2/17/22.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .disableAutocorrection(true)
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
