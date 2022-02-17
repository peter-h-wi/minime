//
//  MyDropDelegate.swift
//  minime
//
//  Created by peter wi on 2/17/22.
//

import Foundation
import SwiftUI

struct MyDropDelegate: DropDelegate {
    let item : DocViewModel
    @ObservedObject var vm: DashBoardViewModel
    @Binding var items : [DocViewModel]
    @Binding var draggedItem : DocViewModel?
    
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedItem = draggedItem else {
            return
        }

        if draggedItem.id != item.id {
            let from = items.firstIndex(where: {$0.id == draggedItem.id})!
            let to = items.firstIndex(where: {$0.id == item.id})!
            withAnimation(.default) {
                self.items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
            }
            //vm.changeLocation()
        }
    }
}
