import Foundation

extension Date {
    
    public var isoDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: self).appending("Z")
    }
    
}
