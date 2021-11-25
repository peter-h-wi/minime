//
//  DocButtonViewModel.swift
//  minime
//
//  Created by peter wi on 11/25/21.
//

import Foundation

final class DocButtonViewModel: Identifiable, ObservableObject {
    @Published var docInfo: DocInfo
    let id = UUID()
    init(_ docInfo: DocInfo) {
        self.docInfo = docInfo
    }
}
