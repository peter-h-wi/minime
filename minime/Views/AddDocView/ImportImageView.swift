//
//  ImportImageView.swift
//  minime
//
//  Created by peter wi on 11/25/21.
//

import SwiftUI

struct ImportImageView: View {
    @Binding var image: Image?
    @Binding var imgTitle: String
    @State private var showingImagePicker = false
    // property to stroe the image the user selected.
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                    .scaledToFit()
                    .frame(height: 300)
                
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .onTapGesture {
                self.showingImagePicker = true
            }
            TextField("Image Title", text: $imgTitle)
        }
        .navigationBarTitle("New Document")
        .navigationBarItems(trailing: Button(action: {}) {
            Text("Save")
        })
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
}

//struct ImportImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImportImageView()
//    }
//}