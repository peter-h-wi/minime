//
//  ImageView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI

struct ImageView: View {
    @State private var imageTitle = "vaccineCard"
    @State private var isLandscape = false
    var body: some View {
        VStack {
            Image(imageTitle)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(.degrees(isLandscape ? 90 : 0))
        }
        .navigationBarItems(trailing: Button(action: {isLandscape.toggle()}) {
            HStack {
                Image(systemName: "rotate.right.fill")
                Text("Rotate")
            }
        })
        
    }
}

struct ImageTopBarView: View {
    @Binding var isLandscape : Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {isLandscape.toggle()}) {
                HStack {
                    Image(systemName: "rotate.right.fill")
                    Text("Rotate")
                }
            }
        }
        .padding()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
.previewInterfaceOrientation(.portrait)
    }
}
