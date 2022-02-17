//
//  DocView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI
import LocalAuthentication

struct DocView: View {
    let doc: DocViewModel
    @State private var isUnlocked = false
    
    var body: some View {
        ZoomableScrollView {
            Image(uiImage: doc.image)
                .renderingMode(.original)
                .resizable()
                .cornerRadius(10)
                .scaledToFit()
                .padding()
        }
        .navigationTitle(doc.title)
        .navigationBarTitleDisplayMode(.inline)
        .disabled(!isUnlocked)
        .blur(radius: isUnlocked ? 0 : 10)
        .opacity(isUnlocked ? 1 : 0.6)
        .onAppear {
            authenticate()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                } else {
                }
            }
        } else {
            // no biometrics
        }
    }
    
}
