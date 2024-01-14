import Foundation
import Combine

enum LogLevel: String {
    case info = "[INFO]" // good to know
    case warning = "[WARNING]" // good to think about
    case error = "[ERROR]" // something bad
    case fatal = "[FATAL]" // something really bad
    case severe = "[SEVERE]" // something really really bad
}

struct LogMessage: Identifiable, Hashable {
    let id = Date()
    let level: LogLevel
    let msg: String
}

final class LogController: ObservableObject {
    
    @Published private(set) var logs: [LogMessage] = []
    public static let shared = LogController()
    private init() {}
    
    public func log(level: LogLevel, msg: String) {
        logs.append(LogMessage(level: level, msg: msg))
    }
    
    public func clearLogs() {
        logs.removeAll()
    }
    
}
