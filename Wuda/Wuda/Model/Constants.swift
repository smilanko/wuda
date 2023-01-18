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
    
    public static let squareSize : CGFloat = 15.0
    
    public static let rootNodeConstant = "ozone"
    public static let rootNodeForGeodasicMap = "geodesicIcosahedron"
    public static let rootNodeForTelescope = "telescope"
    public static let rootNodeForAngles = "angles"
    
    public static let gradientStartColor = NSColor(red: 255/255,green: 206/255,blue: 97/255, alpha: 1.0)
    public static let gradientEndColor = NSColor(red: 191/255, green: 52/255, blue: 117/255, alpha: 1.0)
    public static let atmosphereColor = NSColor(red: 192/255, green: 210/255, blue: 218/255, alpha: 1)
    
}
