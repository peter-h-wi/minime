//
//  ImageInfo.swift
//  minime
//
//  Created by peter wi on 11/25/21.
//

import Foundation
import SwiftUI

struct ImageInfo: Identifiable {
    let id = UUID()
    var title: String = "Image"
    var image: Image?
}
