//
//  DocInfo.swift
//  minime
//
//  Created by peter wi on 11/24/21.
//

import Foundation

struct DocInfo: Identifiable {
    let id = UUID()
    var favorite: Bool = false
    var title: String
    var images: [ImageInfo]?
}

