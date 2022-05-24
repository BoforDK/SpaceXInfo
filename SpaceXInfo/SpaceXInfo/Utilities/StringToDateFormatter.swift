//
//  StringToDateFormatter.swift
//  SpaceXInfo
//
//  Created by Alexander Grigorov on 21.05.2022.
//

import Foundation

class StringToDateFormatter {
    let formatter: DateFormatter
    
    let dateFormat: DateFormat
    
    init(dateFormat: DateFormat) {
        formatter = DateFormatter()
        self.dateFormat = dateFormat
        formatter.dateFormat = dateFormat.rawValue
    }
    
    func date(from: String) -> Date? {
        return formatter.date(from: from)
    }
}

// MARK: Date format enum
extension StringToDateFormatter {
    enum DateFormat: String {
        case utc = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case localUTC = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    }
}
