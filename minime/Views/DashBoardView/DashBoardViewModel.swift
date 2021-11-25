//
//  DashBoardViewModel.swift
//  minime
//
//  Created by peter wi on 11/24/21.
//

import Foundation

final class DashBoardViewModel: ObservableObject {
    
    @Published var searchText : String = ""
    
    @Published var favDocs : [DocInfo] = [DocInfo(title: "Student ID"),
                                          DocInfo(title: "Passport"),
                                          DocInfo(title: "Driver License"),
                                          DocInfo(title: "Vaccination Card")
                                         ]
    @Published var allDocs : [DocInfo] = [DocInfo(title: "Discover Card"),
                                          DocInfo(title: "Business Card"),
                                          DocInfo(title: "Eternals Ticket"),
                                          DocInfo(title: "Six Flag"),
                                          DocInfo(title: "Disney Membership")
                                         ]
    
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
