//
//  Item.swift
//  iOS Intranet
//
//  Created by Fardeen Bablu on 8/23/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
