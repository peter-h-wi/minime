//
//  AddDocViewModel.swift
//  minime
//
//  Created by peter wi on 1/25/22.
//

import Foundation
import CoreData
import UIKit

final class AddDocViewModel: ObservableObject {
    @Published var myTitle : String = ""
    @Published var myFavorite : Bool = false
    @Published var myImage : UIImage? = UIImage(systemName: "photo")
    
    func addDoc() -> Bool {
        guard myTitle != "" else {
            return false
        }
        guard myImage != nil else {
            return false
        }
        
        guard myImage != UIImage(systemName: "photo") else {
            return false
        }
        
        let docData = DocData(context: CoreDataManager.shared.viewContext)
        docData.title = myTitle
        docData.favorite = myFavorite
        docData.image = myImage!.jpegData(compressionQuality: 1.0)
        docData.colorIndex = Int64(Int.random(in: 0...10))
        
        CoreDataManager.shared.save()
        resetDoc()
        return true
    }
    
    func resetDoc() {
        myTitle = ""
        myFavorite = false
        myImage = UIImage(systemName: "photo")
    }
}
 
