//
//  ImageView.swift
//  minime
//
//  Created by peter wi on 2/17/22.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var AddDocVM: AddDocViewModel
    @Binding var showingImagePicker: Bool
    @Binding var inputImage: UIImage?
    let geoWidth: Double
    let geoHeight: Double
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.secondary)
                    .scaledToFit()
                    .frame(width: geoWidth*0.9)
                if AddDocVM.myImage == UIImage(systemName: "photo") {
                    Image(uiImage: AddDocVM.myImage!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geoWidth*0.3, alignment: .center)
                } else {
                    Image(uiImage: AddDocVM.myImage!)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geoWidth*0.9)
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
        .frame(height: geoHeight*0.5)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        AddDocVM.myImage = inputImage
    }
}
