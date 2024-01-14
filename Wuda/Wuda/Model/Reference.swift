import Foundation
import simd

enum Reference: CaseIterable, Identifiable, CustomStringConvertible {

    var description: String {
        switch self {
        case .smartDevice:
            "smart device"
        case .zminus:
            "0,0,-1"
        case .yminus:
            "0,-1,0"
        case .xminus:
            "-1,0,0"
        case .zplus:
            "0,0,1"
        case .yplus:
            "0,1,0"
        case .xplus:
            "1,0,0"
        }
    }

    var id: Self { self }
    case smartDevice
    case zminus
    case yminus
    case xminus
    case zplus
    case yplus
    case xplus
    
    func toSimd() -> simd_quatd? {
        switch self {
        case .smartDevice:
            return nil
        case .zminus:
            return simd_quatd(ix: 0, iy: 0, iz: -1, r: 0)
        case .yminus:
            return simd_quatd(ix: 0, iy: -1, iz: 0, r: 0)
        case .xminus:
            return simd_quatd(ix: -1, iy: 0, iz: 0, r: 0)
        case .zplus:
            return simd_quatd(ix: 0, iy: 0, iz: 1, r: 0)
        case .yplus:
            return simd_quatd(ix: 0, iy: 1, iz: 0, r: 0)
        case .xplus:
            return simd_quatd(ix: 1, iy: 0, iz: 0, r: 0)
        }
    }
}
