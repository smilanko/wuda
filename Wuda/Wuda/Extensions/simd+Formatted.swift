import Foundation
import simd

public enum Axis: String, CaseIterable {
    case x = "x-axis"
    case y = "y-axis"
    case z = "z-axis"
}

extension simd_quatd {
    
    public var formatted: String {
        "(w:\(String(format: "%.3f", self.vector.w)),x:\(String(format: "%.3f", self.vector.x)),y:\(String(format: "%.3f", self.vector.y)),z:\(String(format: "%.3f", self.vector.z)))"
    }
    
    public static func buildQuaternionForRotation(angle: Double, axis: Axis) -> simd_quatd {
        let rads = Measurement(value: angle, unit: UnitAngle.degrees).converted(to: .radians).value / 2.0
        switch axis {
        case .x:
            return simd_quatd(ix: sin(rads), iy: 0, iz: 0, r: cos(rads))
        case .y:
            return simd_quatd(ix: 0, iy: sin(rads), iz: 0, r: cos(rads))
        case .z:
            return simd_quatd(ix: 0, iy: 0, iz: sin(rads), r: cos(rads))
        }
    }
    
}

extension simd_double4 {
    
    var norm: Double {
        (w * w) + (x * x) + (y * y) + (z * z)
    }
    
}
