import Foundation

enum Reference: String, CaseIterable, Identifiable {
    var id: Self { self }
    case smartWatch = "smartWatch"
    case zminus = "0,0,-1"
    case yminus = "0,-1,0"
    case xminus = "-1,0,0"
    case zplus = "0,0,1"
    case yplus = "0,1,0"
    case xplus = "1,0,0"
}
