//
//  SCNVector3+Distance.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SceneKit
import simd

extension SCNVector3 {
    
    func distance(to vector: SCNVector3) -> Float {
         return simd_distance(simd_float3(self), simd_float3(vector))
     }
    
}
