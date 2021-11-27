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
    @State private var images: [Image] = [Image(systemName: "photo")]
    @State private var imgTitles: [String] = [""]
    
    var body: some View {
        Form {
            Section("Title") {
                TextField("Document Title", text: $title)
            }
            if let images = images {
                ForEach(images.indices, id: \.self) { i in
                    Section("Image \(i+1)") {
                        ImportImageView(image: $images[i], imgTitle: $imgTitles[i])
                    }
                }
            }

            Button(action: {
                images.append(Image(systemName: "photo"))
                imgTitles.append("")
            }) {
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") { }
            }
        }
    }
}

struct AddDocView_Previews: PreviewProvider {
    static var previews: some View {
        AddDocView()
    }
}
