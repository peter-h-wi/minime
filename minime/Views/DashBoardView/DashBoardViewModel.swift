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
    @Published var draggedItem : DocViewModel?
    
    func fetchAllDocs() {
        docs = CoreDataManager.shared.getAllDocs().map(DocViewModel.init)
    }
    
    func getFilteredDocs() -> [DocViewModel]{
        if (searchText == "") {
            return docs
        }
        return docs.filter { doc in
            return doc.title.contains(searchText)
        }
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
    
    func changeLocation() {
        CoreDataManager.shared.save()
    }
}
