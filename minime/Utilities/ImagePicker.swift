//
//  ImagePicker.swift
//  minime
//
//  Created by peter wi on 11/25/21.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    
    // UIKit uses delegations
    // delegate class: need to conform to one or more protocols.
    // SwiftUI handles these delegate classes by letting us define a coordinator that belongs to the struct.
        // 1. acting as the delegate for UIKit components
        // 2. pass any relevant information back up to the ImagePicker that owns it.
    // NSObject: is the base class for most types that come from UIKit.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        // "let parent: ImagePicker" : means we need to create it with a reference to the image picker that owns it, so the coordinator can forward on interesting events.
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // didFinishPickingMediaWithInfo: is called when the user has selected an image, and will be given a dictionary of information about the selected image.U
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    // makeCoordinator() method: tells SwiftUI to use the Coordinator class for the ImagePicker coordinator. Also, it lets us control how the coordinator is made.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // UIViewControllerRepresentable: means that ImagePicker is already a SwiftUI view that we can place inside our view hierarchy. --> In this instance we're wrapping UIKit's UIImagePickerController.
    // UIImagePickerController: lets the user select somthing from their photo library
    
    // When that ImagePicker struct is created, SwiftUI will automatically call its makeUIViewController()
    // makeUIViewController() method: goes on to create and send back a UIImagePickerController.
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        // because our coordinator class conforms to the UIImagePickerControllerDelegate protocol, we can make it the delegate of the UIKit image picker.
        picker.delegate = context.coordinator
        return picker
    }
    
    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}
