import CoreBluetooth
import Foundation

extension CBManagerState: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .unknown:
            "Unknown"
        case .resetting:
            "Resetting"
        case .unsupported:
            "Unsupproted"
        case .unauthorized:
            "Unautorized"
        case .poweredOff:
            "Powered Off"
        case .poweredOn:
            "Powered On"
        default:
            "Unknown"
        }
    }
    
}
