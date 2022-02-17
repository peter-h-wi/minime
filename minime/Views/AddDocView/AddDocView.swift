//
//  AddDocView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI
import UIKit

struct AddDocView: View {
    @StateObject var AddDocVM = AddDocViewModel()
    @ObservedObject var DashBoardVM : DashBoardViewModel
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center) {
                    ImageView(AddDocVM: AddDocVM, showingImagePicker: $showingImagePicker, inputImage: $inputImage, geoWidth: geo.size.width, geoHeight: geo.size.height)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("What is it?")
                                .font(Font.title3.weight(.bold))
                                .frame(maxWidth: geo.size.width*0.3, alignment: .leading)
                            .padding(7)
                            TextField("Type the title", text: $AddDocVM.myTitle)
                                .padding(7)
                                .padding(.horizontal, 10)
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                                .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue:0/255).opacity(0.25), radius: 8, x: 0, y: 4)
                        }
                        
                        Divider()
                        
                        Toggle("Use Often?", isOn: $AddDocVM.myFavorite)
                            .font(Font.title3.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(7)
                            .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue:0/255).opacity(0.25), radius: 8, x: 0, y: 4)
                        
                        Divider()
                    }
                    
                    Button(action: {
                        if (AddDocVM.addDoc()) {
                            DashBoardVM.fetchAllDocs()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus.app")
                            Text("Save")
                                .bold()
                                .padding(.vertical, 8)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .clipped()
                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color.cyan).opacity(disableSave ? 0.5 : 1))
                        .font(.title3)
                        .foregroundColor(.white)
                        .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue:0/255).opacity(0.25), radius: 8, x: 0, y: 4)
                    }
                    .disabled(disableSave)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .clipped()
            .padding(.top, 10)
        .navigationTitle("New Document")
        .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    var disableSave: Bool {
        AddDocVM.myImage == UIImage(systemName: "photo") || AddDocVM.myTitle.isEmpty
    }
}
