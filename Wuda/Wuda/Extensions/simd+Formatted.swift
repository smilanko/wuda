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
    
}
