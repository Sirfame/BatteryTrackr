//
//  Battery.swift
//  BatteryTrackr
//
//  Created by Lin, Sirfame on 1/24/19.
//  Copyright © 2019 Sirfame Lin. All rights reserved.
//

import Foundation

struct Battery {
    let text: String
    let author: String
    
    static let all: [Battery] =  [
        Battery(text: "Never put off until tomorrow what you can do the day after tomorrow.", author: "Mark Twain"),
        Battery(text: "Efficiency is doing better what is already being done.", author: "Peter Drucker"),
        Battery(text: "To infinity and beyond!", author: "Buzz Lightyear"),
        Battery(text: "May the Force be with you.", author: "Han Solo"),
        Battery(text: "Simplicity is the ultimate sophistication", author: "Leonardo da Vinci"),
        Battery(text: "It’s not just what it looks like and feels like. Design is how it works.", author: "Steve Jobs")
    ]
}

extension Battery: CustomStringConvertible {
    var description: String {
        return "\"\(text)\" — \(author)"
    }
}
