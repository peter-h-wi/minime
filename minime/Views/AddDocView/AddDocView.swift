//
//  AddDocView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI

struct AddDocView: View {
    // @StateObject private var DashBoardVM = DashBoardViewModel()
    // @State private var
    @State private var title = ""
    @State private var imgTitle1 = ""
    @State private var image1: Image?
    
    var body: some View {
        Form {
            Section("Title") {
                TextField("Document Title", text: $title)
            }
            
            Section("Image 1") {
                ImportImageView(image: $image1, imgTitle: $imgTitle1)
            }
            Button(action: {}) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Image")
                }
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.blue)
                    .opacity(0.7)
            )
            
            .contentShape(Rectangle())
        }
        .navigationTitle("New Document")
        .navigationBarItems(trailing: Button(action: {
            //count += 1
        }) {
            Text("Save")
        })
    }
}

struct AddDocView_Previews: PreviewProvider {
    static var previews: some View {
        AddDocView()
    }
}
