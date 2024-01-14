import Foundation
import Combine

final class SessionState: NSObject, ObservableObject {
    
    @Published private(set) var defaultPoint: Reference = .zminus
    @Published private(set) var defaultActivity: String = ""
    
    public static let shared = SessionState()
    private override init() {}
    
    func updatePoint(newPoint: Reference) {
        self.defaultPoint = newPoint
    }
    
    func updateActivity(newActivity: String) {
        self.defaultActivity = newActivity
    }
    
}
