//
//  LogController.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI

enum LogMessageType : String {
    case info = "[INFO]"
    case error = "[ERROR]"
    case fatal = "[FATAL]"
    case severe = "[SEVERE]"
    case warning = "[WARNING]"
}

struct LogMessage : Identifiable {
    let id = Date()
    let type : LogMessageType
    let msg : String
}

class LogController: ObservableObject {
    
    @Published private(set) var logMessages : [LogMessage] = []
    
    public static var shared = LogController()
    
    private init() {}
    
    public func addLogMessage(type: LogMessageType, msg: String) {
        logMessages.append(LogMessage(type: type, msg: msg))
    }
    
}
