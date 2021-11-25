//
//  DocSettingView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI

struct DocSettingView: View {
    @State private var isFavorite = false
    @State private var docTitle = "Vaccine Card"
    @State private var images = ["vaccineCard", "driverLicense"]
    @State private var count = 0
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach(0..<images.count) { number in
                    VStack {
                        Text("Image \(number+1)")
                            .font(Font.title3.weight(.semibold))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        Image(images[number])
                            .resizable()
                            .frame(width: 300, height: 200)
                    }
                }
                
                Button(action: {count += 1}) {
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
    //                    .fill(LinearGradient(
    //                          gradient: .init(colors: [gradientStart, gradientEnd]),
    //                          startPoint: .init(x: 0.5, y: 0),
    //                          endPoint: .init(x: 0.5, y: 0.6)
    //                        )))
                        .fill(.blue)
                        .opacity(0.7)
                )
                
                
                .contentShape(Rectangle())
                

            }
                .frame(maxWidth: .infinity)
                //.padding(.top, 59)
                .background(Color.gray.opacity(0.05))
        }
        .navigationTitle(docTitle)
        .navigationBarItems(trailing: Button(action: {
            isFavorite.toggle()
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.gray)
                .font(.title2)
        })
        //.overlay(DocSettingTopBarView(isFavorite: $isFavorite, docTitle: $docTitle), alignment: .top)
    }
    
}

struct DocSettingTopBarView: View {
    @Binding var isFavorite: Bool
    @Binding var docTitle: String
    @State private var count = 1
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                isFavorite.toggle()
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.gray)
                    .font(.title2)
            }
            TextField(docTitle, text: $docTitle)
                .font(Font.title.weight(.bold))
            
            Spacer()
            Button(action: {
                count += 1
            }) {
                Image(systemName: "x.circle.fill")
                    .foregroundColor(.gray)
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.regularMaterial)
        
    }
}

struct DocSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DocSettingView()
    }
}
