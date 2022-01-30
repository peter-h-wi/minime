//
//  AuthenticationView.swift
//  minime
//
//  Created by peter wi on 1/26/22.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var AuthVM: AuthenticationViewModel = AuthenticationViewModel()
    @Binding var isLogined: Bool
    
    var body: some View {
        
        GeometryReader { geo in
            NavigationView {
                VStack(spacing: geo.size.height*0.04) {
                    Image(systemName: "lock.fill")
                        .font(.largeTitle)
                    VStack(alignment: .center, spacing: 0) {
                        Text("Enter Passcode")
                            .font(.title)
                            .padding(.bottom, geo.size.height*0.001)
                        Text("Your passcod is required")
                            .font(.subheadline)
                        Text("to enable Face ID")
                            .font(.subheadline)
                    }
                    
                    HStack {
                        Image(systemName: AuthVM.inputCount > 0 ? "circle.fill" : "circle")
                        Image(systemName: AuthVM.inputCount > 1 ? "circle.fill" : "circle")
                        Image(systemName: AuthVM.inputCount > 2 ? "circle.fill" : "circle")
                        Image(systemName: AuthVM.inputCount > 3 ? "circle.fill" : "circle")
                        Image(systemName: AuthVM.inputCount > 4 ? "circle.fill" : "circle")
                        Image(systemName: AuthVM.inputCount > 5 ? "circle.fill" : "circle")
                    }
                    ForEach(datas) {i in
                        HStack(spacing: geo.size.width*0.05) {
                            ForEach(i.row) {j in
                                Button(action: {
                                    AuthVM.clickPasscodeButton(of: j.value)
                                    if (AuthVM.inputCount == 6) {
                                        if (!AuthVM.checkPasscode()) {
                                            // login fail
                                            AuthVM.resetAuth()
                                        } else {
                                            isLogined = true
                                        }
                                    }
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.gray.opacity(0.5))
                                            .frame(maxWidth: geo.size.width*0.2, maxHeight:  geo.size.width*0.2)
                                        Text(j.value).font(.largeTitle).fontWeight(.regular).padding(.vertical)
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("Cancel")
                                .font(.body)
                        }
                    }
                    .padding(.horizontal, geo.size.width*0.2)
                    .padding(.bottom, geo.size.height*0.2)
                }
                .foregroundColor(.white)
            }
            .preferredColorScheme(.dark)
        }
        
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(isLogined: .constant(false))
    }
}

struct type : Identifiable {
    var id: Int
    var row: [row]
}

struct row : Identifiable {
    var id: Int
    var value: String
}

var datas = [
type(id: 0, row: [row(id: 0, value: "1"),row(id: 1, value: "2"),row(id: 2, value: "3")]),
type(id: 1, row: [row(id: 0, value: "4"),row(id: 1, value: "5"),row(id: 2, value: "6")]),
type(id: 2, row: [row(id: 0, value: "7"),row(id: 1, value: "8"),row(id: 2, value: "9")]),
type(id: 3, row: [row(id: 0, value: "0")]),

]
