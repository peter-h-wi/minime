//
//  DocViewModel.swift
//  minime
//
//  Created by peter wi on 1/25/22.
//

import Foundation
import CoreData
import UIKit

struct DocViewModel {
    let docData: DocData
    
    var id: NSManagedObjectID {
        return docData.objectID
    }
    
    var title: String {
        return docData.title ?? ""
    }
    
    var image: UIImage {
        return UIImage(data: docData.image!)!
    }
    
    var favorite: Bool {
        return docData.favorite
    }
    
    var colorIndex: Int {
        return Int(docData.colorIndex)
    }
}
