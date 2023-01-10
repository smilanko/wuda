//
//  WudaConstants.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import simd

struct WudaConstants {
    
    static let cosFunction = "acos"
    static let sinFunction = "asin"

    static let quatPointXMinStr = "<-1,0,0>"
    static let quatPointXPlusStr = "<1,0,0>"
    static let quatPointYMinStr = "<0,-1,0>"
    static let quatPointYPlusStr = "<0,1,0>"
    static let quatPointZMinStr = "<0,0,-1>"
    static let quatPointZPlusStr = "<0,0,1>"
    
    static let quatPointXMin = simd_quatd(ix: -1, iy: 0, iz: 0, r: 0)
    static let quatPointXPlus = simd_quatd(ix: 1, iy: 0, iz: 0, r: 0)
    static let quatPointYMin = simd_quatd(ix: 0, iy: -1, iz: 0, r: 0)
    static let quatPointYPlus = simd_quatd(ix: 0, iy: 1, iz: 0, r: 0)
    static let quatPointZMin = simd_quatd(ix: 0, iy: 0, iz: -1, r: 0)
    static let quatPointZPlus = simd_quatd(ix: 0, iy: 0, iz: 1, r: 0)
    
    static let xAxis = "x-axis"
    static let yAxis = "y-axis"
    static let zAxis = "z-axis"
    
}
