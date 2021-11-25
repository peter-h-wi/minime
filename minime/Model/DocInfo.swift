//
//  DocInfo.swift
//  minime
//
//  Created by peter wi on 11/24/21.
//

import Foundation

class DocInfo: ObservableObject, Identifiable, Hashable {
    static func == (lhs: DocInfo, rhs: DocInfo) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
    
    let id = UUID()
    @Published var title: String
    @Published var images: [ImageInfo]? = nil
    let colorIndex = Int.random(in: 0..<11)
    
    init(title: String) {
        self.title = title
    }
    
    init(title: String, images: [ImageInfo]) {
        self.title = title
        self.images = images
    }
}

