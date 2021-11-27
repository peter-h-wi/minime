//
//  minimeApp.swift
//  minime
//
//  Created by peter wi on 11/23/21.
//

import SwiftUI

@main
struct minimeApp: App {
    var body: some Scene {
        WindowGroup {
            DashBoardView()
            .environmentObject(DashBoardViewModel())
        }
    }
}
