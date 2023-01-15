//
//  LogMessage.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation

enum LogMessageType : String {
    case error = "[ERROR]"
    case info = "[INFO]"
}

struct LogMessage : Identifiable {
    
    let id = Date()
    let type : LogMessageType
    let msg : String
    
}
