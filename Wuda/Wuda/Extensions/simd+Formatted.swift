//
//  simd+Formatted.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import simd

extension simd_quatd {
    
    public var prettyPrint : String {
        return "(w:\(String(format: "%.3f", self.vector.w)),x:\(String(format: "%.3f", self.vector.x)),y:\(String(format: "%.3f", self.vector.y)),z:\(String(format: "%.3f", self.vector.z)))"
    }
    
    public static func build(x: Double, y: Double, z: Double) -> simd_quatd {
        if x != 0 {
            let rads = Measurement(value: x, unit: UnitAngle.degrees).converted(to: .radians).value / 2.0
            return simd_quatd(ix: sin(rads), iy: 0, iz: 0, r: cos(rads))
        } else if y != 0 {
            let rads = Measurement(value: y, unit: UnitAngle.degrees).converted(to: .radians).value / 2.0
            return simd_quatd(ix: 0, iy: sin(rads), iz: 0, r: cos(rads))
        } else if z != 0 {
            let rads = Measurement(value: z, unit: UnitAngle.degrees).converted(to: .radians).value / 2.0
            return simd_quatd(ix: 0, iy: 0, iz: sin(rads), r: cos(rads))
        }
        fatalError("This contructor is a helper for the quaternion shifting view")
    }
    
}
