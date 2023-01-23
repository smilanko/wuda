//
//  LogController.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI

enum LogMessageType : String {
    case info = "[INFO]" // good to know
    case warning = "[WARNING]" // good to think about
    case error = "[ERROR]" // something bad
    case fatal = "[FATAL]" // something really bad
    case severe = "[SEVERE]" // something really really bad
}

struct LogMessage : Identifiable, Hashable {
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
    
    public func clearLogs() {
        logMessages = []
    }
    
}
