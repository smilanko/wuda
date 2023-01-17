//
//  Constants.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import simd
import SwiftUI

struct Constants {
    
    private init() {}
    
    public static let xAxis = "x-axis"
    public static let yAxis = "y-axis"
    public static let zAxis = "z-axis"
    
    public static let cosFunction = "acos"
    public static let sinFunction = "asin"

    public static let quatPointXMinStr = "<-1,0,0>"
    public static let quatPointXPlusStr = "<1,0,0>"
    public static let quatPointYMinStr = "<0,-1,0>"
    public static let quatPointYPlusStr = "<0,1,0>"
    public static let quatPointZMinStr = "<0,0,-1>"
    public static let quatPointZPlusStr = "<0,0,1>"
    
    public static let quatPointXMin = simd_quatd(ix: -1, iy: 0, iz: 0, r: 0)
    public static let quatPointXPlus = simd_quatd(ix: 1, iy: 0, iz: 0, r: 0)
    public static let quatPointYMin = simd_quatd(ix: 0, iy: -1, iz: 0, r: 0)
    public static let quatPointYPlus = simd_quatd(ix: 0, iy: 1, iz: 0, r: 0)
    public static let quatPointZMin = simd_quatd(ix: 0, iy: 0, iz: -1, r: 0)
    public static let quatPointZPlus = simd_quatd(ix: 0, iy: 0, iz: 1, r: 0)
    
    public let axisOptions = [xAxis, yAxis, zAxis]
    public let trigOptions = [cosFunction, sinFunction]
    public let pointOptions = [quatPointXMin, quatPointXPlus, quatPointYMin, quatPointYPlus, quatPointZMin, quatPointZPlus]
    public let pointOptionStrings = [quatPointXMinStr, quatPointXPlusStr, quatPointYMinStr, quatPointYPlusStr, quatPointZMinStr, quatPointZPlusStr]
    
    public static let rootNodeConstant = "ozone"
    public static let rootNodeForGeodasicMap = "geodesicIcosahedron"
    
    public static let gradientStartColor = NSColor(red: 255/255,green: 206/255,blue: 97/255, alpha: 1.0)
    public static let gradientEndColor = NSColor(red: 191/255, green: 52/255, blue: 117/255, alpha: 1.0)
    
}
