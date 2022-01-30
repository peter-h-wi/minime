//
//  PasscodeModel.swift
//  minime
//
//  Created by peter wi on 1/28/22.
//

import Foundation
import CoreData

struct PasscodeModel {
    let passcodeData: PasscodeData
    
    var id: NSManagedObjectID {
        return passcodeData.objectID
    }
    
    var passwordHash: String {
        return passcodeData.passwordHash ?? ""
    }
}
