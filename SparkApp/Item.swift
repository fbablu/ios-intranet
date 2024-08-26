//
//  Item.swift
//  Spark
//
//  Created by Fardeen Bablu on 8/4/24.
//

import Foundation
import SwiftData

/// A model representing an item with a timestamp
@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
