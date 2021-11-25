//
//  DashBoardViewModel.swift
//  minime
//
//  Created by peter wi on 11/24/21.
//

import Foundation

final class DashBoardViewModel: ObservableObject {
    
    @Published var searchText : String = ""
    
    @Published var favDocList = DocButtonListViewModel(
        [DocButtonViewModel(DocInfo(favorite: true, title: "Student ID")),
         DocButtonViewModel(DocInfo(favorite: true, title: "Passport")),
         DocButtonViewModel(DocInfo(favorite: true, title: "Driver License")),
         DocButtonViewModel(DocInfo(favorite: true, title: "Vaccination Card"))
        ]
    )
    @Published var allDocList = DocButtonListViewModel(
        [DocButtonViewModel(DocInfo(title: "Discover Card")),
         DocButtonViewModel(DocInfo(title: "Business Card")),
         DocButtonViewModel(DocInfo(title: "Eternals Ticket")),
         DocButtonViewModel(DocInfo(title: "Six Flag")),
         DocButtonViewModel(DocInfo(title: "Disney Membership")),
        ]
    )
//
//    func addDocument(docInfo: DocInfo) {
//        docInfos.append(docInfo)
//    }
//
//    func deleteDocument(docIndex: Int) {
//        docInfos.remove(at: docIndex)
//    }
//
//    func modifyDocument(docIndex: Int, docInfo: DocInfo) {
//        docInfos[docIndex] = docInfo
//    }
//
//    func addToFavorite(docInfo: DocInfo, docIndex: Int) {
//        favDocInfos.append(docInfo)
//        deleteDocument(docIndex: docIndex)
//    }
//
//    func removeFromFavorite(docInfo: DocInfo, docIndex: Int) {
//        docInfos.append(docInfo)
//        favDocInfos.remove(at: docIndex)
//    }
//
//    func modifyFromFavorite(docIndex: Int, docInfo: DocInfo) {
//        favDocInfos[docIndex] = docInfo
//    }
}
