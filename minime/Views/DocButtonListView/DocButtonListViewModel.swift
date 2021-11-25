//
//  DocButtonListViewModel.swift
//  minime
//
//  Created by peter wi on 11/25/21.
//

import Foundation

final class DocButtonListViewModel: ObservableObject {
    @Published var docVMList: [DocButtonViewModel]?
    init(_ docVMList: [DocButtonViewModel]) {
        self.docVMList = docVMList
    }
}
