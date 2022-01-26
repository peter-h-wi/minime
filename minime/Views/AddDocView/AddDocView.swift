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
    @StateObject var DashBoardVM : DashBoardViewModel
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
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
                            if AddDocVM.myImage == UIImage(systemName: "photo") {
                                Image(uiImage: AddDocVM.myImage!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width*0.3, alignment: .center)
                            } else {
                                Image(uiImage: AddDocVM.myImage!)
                                    .renderingMode(.original)
                                    .resizable()
                                    //.scaledToFit()
                                    .frame(width: geo.size.width*0.9)
                                    .cornerRadius(10)
                            }
                        }
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                        //TextField("Image Title", text: $imgTitle)
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: $AddDocVM.myImage)
                    }
                    .frame(height: geo.size.height*0.5)
                    
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
                                        .fill(Color.cyan))
                        .font(.title3)
                        .foregroundColor(.white)
                        .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue:0/255).opacity(0.25), radius: 8, x: 0, y: 4)
                    }
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
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        AddDocVM.myImage = inputImage
    }
}

//struct AddDocView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDocView()
//    }
//}
