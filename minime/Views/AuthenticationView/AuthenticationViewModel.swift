//
//  AuthenticationViewModel.swift
//  minime
//
//  Created by peter wi on 1/26/22.
//

import Foundation
import CoreData
import CryptoKit

final class AuthenticationViewModel: ObservableObject {
    @Published var inputCount = 0;
    @Published var inputPasscode: String = ""
    
    func checkPasscode() -> Bool {
        if (inputCount != 6) {
            return false
        }
        return true
//        let password = CoreDataManager.shared.getCredential().map(PasscodeModel.init)
//        if (password.count>0) {
//            let inputData = Data(inputPasscode.utf8)
//            let hashed = SHA256.hash(data: inputData)
//            return hashed.description == password[0].passwordHash
//        }
//        return false
    }
    
    func clickPasscodeButton(of number: String) {
        inputPasscode += number
        inputCount += 1
    }
    
    func resetAuth() {
        inputCount = 0
        inputPasscode = ""
    }
    
    
    
    
}
