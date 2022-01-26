//
//  DashBoardViewModel.swift
//  minime
//
//  Created by peter wi on 11/24/21.
//

import Foundation

final class DashBoardViewModel: ObservableObject {
    
    @Published var searchText : String = ""
    @Published var docs : [DocViewModel] = []
    
    func fetchAllDocs() {
        docs = CoreDataManager.shared.getAllDocs().map(DocViewModel.init)
    }
    
    func getFavoriteDocs() -> [DocViewModel]{
        return docs.filter { doc in
            return doc.favorite == true
        }
    }
    
    func getAllDocs() -> [DocViewModel] {
        return docs.filter { doc in
            return doc.favorite == false
        }
    }
    
    func delete(_ doc: DocViewModel) {
        let existingDoc = CoreDataManager.shared.getDocById(id: doc.id)
        if let existingDoc = existingDoc {
            CoreDataManager.shared.deleteDoc(doc: existingDoc)
        }
    }
    
    func toggleFavoriteOf(_ doc: DocViewModel) {
        let existingDoc = CoreDataManager.shared.getDocById(id: doc.id)
        if let existingDoc = existingDoc {
            existingDoc.favorite = !existingDoc.favorite
            CoreDataManager.shared.save()
        }
    }
    
    
    
    
    
    
    
    @Published var favDocs : [DocInfo] = []
    @Published var allDocs : [DocInfo] = []
    
    
    func addDocument(docInfo: DocInfo, favorite: Bool) {
        if (favorite) {
            favDocs.append(docInfo)
        } else {
            allDocs.append(docInfo)
        }
    }

    func deleteDocument(docInfo: DocInfo, favorite: Bool) {
        if (favorite) {
            favDocs.removeAll(where: {$0.id == docInfo.id })
        } else {
            allDocs.removeAll(where: {$0.id == docInfo.id })
        }
    }

    func modifyDocument(docInfo: DocInfo, favorite: Bool) {
        if (favorite) {
            if let index = favDocs.firstIndex(where: {$0.id == docInfo.id}) {
                favDocs[index] = docInfo
            }
        } else {
            if let index = allDocs.firstIndex(where: {$0.id == docInfo.id}) {
                allDocs[index] = docInfo
            }
            allDocs.append(docInfo)
        }
    }
}

extension DashBoardViewModel {
    static var favExample: [DocInfo] {
        [DocInfo(title: "Student ID"),
         DocInfo(title: "Passport"),
         DocInfo(title: "Driver License"),
         DocInfo(title: "Vaccination Card")
        ]
    }
    
    static var allExample: [DocInfo] {
        [DocInfo(title: "Discover Card"),
         DocInfo(title: "Business Card"),
         DocInfo(title: "Eternals Ticket"),
         DocInfo(title: "Six Flag"),
         DocInfo(title: "Disney Membership")
        ]
    }
}
