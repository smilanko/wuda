//
//  Date+Formatted.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation

extension Date {
    
    public func isoDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: self).appending("Z")
    }
    
}
