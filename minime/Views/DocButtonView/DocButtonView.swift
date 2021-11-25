//
//  DocButtonView.swift
//  minime
//
//  Created by peter wi on 11/25/21.
//

import SwiftUI

struct DocButtonView: View {
    @ObservedObject var docVM: DocButtonViewModel
    let buttonColor: Color
    
    var body: some View {
        NavigationLink(destination: DocView()) {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        self.docVM.docInfo.favorite.toggle()
                    }) {
                        Image(systemName: self.docVM.docInfo.favorite ? "heart.fill" : "heart")
                            .font(Font.title2.weight(.semibold))
                            .foregroundColor(.yellow)
                    }
                    Spacer()
                    NavigationLink(destination: DocSettingView()) {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(Font.title2.weight(.semibold))
                    }
                }
                Text(self.docVM.docInfo.title)
                    .font(Font.title3.weight(.semibold))
                    .multilineTextAlignment(.leading)
                    .frame(width: 134, height: 50, alignment: .bottomLeading)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(buttonColor))
            
            .contentShape(Rectangle())
        }
        
    }
}


struct DocButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DocButtonView(docVM: DocButtonViewModel(DocInfo(favorite: true, title: "test image", images: nil)), buttonColor: .green)
    }
}
