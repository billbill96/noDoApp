//
//  NoDoModel.swift
//  NoDoApp
//
//  Created by Supannee Mutitanon on 3/5/20.
//  Copyright © 2020 Supannee Mutitanon. All rights reserved.
//

import Foundation
import SwiftUI

let dateFormatter = DateFormatter()

struct NoDo: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String = ""
    var isDone: Bool = false
    
    var dateAdded = Date()
    var dateText: String {
        dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
        return dateFormatter.string(from: dateAdded)
    }
}
