//
//  DocView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI

struct DocView: View {
    let doc: DocViewModel
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack(alignment: .center) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.secondary)
                                .scaledToFit()
                                .frame(width: geo.size.width*0.9)
                            Image(uiImage: doc.image)
                                .renderingMode(.original)
                                .resizable()
                                //.scaledToFit()
                                .frame(width: geo.size.width*0.9)
                                .cornerRadius(10)
                        }
                    }
                    .frame(height: geo.size.height*0.5)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("What is it?")
                                .font(Font.title3.weight(.bold))
                                .frame(maxWidth: geo.size.width*0.3, alignment: .leading)
                            .padding(7)
                            Text(doc.title)
                                .padding(7)
                                .padding(.horizontal, 10)
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                        }
                        
                        Divider()
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .clipped()
            .padding(.top, 10)
            .navigationTitle(doc.title)
            .navigationBarTitleDisplayMode(.inline)
        }
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


//struct DocView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocView()
//    }
//}
