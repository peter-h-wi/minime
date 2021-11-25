//
//  AddDocView.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI

struct AddDocView: View {
    var body: some View {
        Form {
            Section("Title") {
                Text("Vaccine")
            }
            
            Section("Image") {
                ImportImageView()
            }
        }
    }
}

struct AddDocView_Previews: PreviewProvider {
    static var previews: some View {
        AddDocView()
    }
}
