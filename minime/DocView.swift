//
//  DocView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI

struct DocView: View {
    @State private var docTitle = "Vaccination Card"
    @State private var images = ["vaccineCard", "driverLicense"]
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<images.count) { number in
                    NavigationLink(destination: ImageView()) {
                        Image(images[number])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
            }
                .frame(maxWidth: .infinity)
                //.padding(.top, 59)
                .background(Color.gray.opacity(0.05))
        }
        .navigationTitle(docTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    
                }
            }
        }
//        .navigationBarItems(trailing: Button(action: {
//            //count += 1
//        }) {
//            Text("Edit")
//        })
        //.overlay(DocTopBarView(docTopBarTitle: docTitle), alignment: .top)
    }
        
    
}

struct DocTopBarView: View {
    let docTopBarTitle: String
    @State private var count = 1
    var body: some View {
        HStack(spacing: 20) {
            Text(docTopBarTitle)
                .font(Font.title.weight(.bold))
                
            Spacer()
            Button(action: {
                count += 1
            }) {
                Text("Edit")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.regularMaterial)
        
    }
}


struct DocView_Previews: PreviewProvider {
    static var previews: some View {
        DocView()
    }
}
