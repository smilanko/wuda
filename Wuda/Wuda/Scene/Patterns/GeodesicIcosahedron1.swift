//
//  GeodesicIcosahedron1.swift
//  Wuda
//
//  Found on an online source:
//  http://dmccooey.com/polyhedra/GeodesicIcosahedron1.html
//  A thank you to the author
//

import Foundation
import SceneKit

class GeodesicIcosahedron1 : Pattern {
    
    let C0 = 0.381966011250105151795413165634
    let C1 = 0.548231992894670430445002211178
    let C2 = 0.618033988749894848204586834366
    let C3 = 0.8870579982236676076112505527946
    
    public func generateVertices() -> [SCNVector3] {
        return [SCNVector3( 0.0, C0, 1.0), SCNVector3( 0.0, C0, -1.0), SCNVector3( 0.0, -C0, 1.0), SCNVector3( 0.0, -C0, -1.0), SCNVector3( 1.0, 0.0, C0), SCNVector3( 1.0, 0.0, -C0), SCNVector3(-1.0, 0.0, C0), SCNVector3(-1.0, 0.0, -C0), SCNVector3( C0, 1.0, 0.0), SCNVector3( C0, -1.0, 0.0), SCNVector3( -C0, 1.0, 0.0), SCNVector3( -C0, -1.0, 0.0), SCNVector3( C1, 0.0, C3), SCNVector3( C1, 0.0, -C3), SCNVector3( -C1, 0.0, C3), SCNVector3( -C1, 0.0, -C3), SCNVector3( C3, C1, 0.0), SCNVector3( C3, -C1, 0.0), SCNVector3( -C3, C1, 0.0), SCNVector3( -C3, -C1, 0.0), SCNVector3( 0.0, C3, C1), SCNVector3( 0.0, C3, -C1), SCNVector3( 0.0, -C3, C1), SCNVector3( 0.0, -C3, -C1), SCNVector3( C2, C2, C2), SCNVector3( C2, C2, -C2), SCNVector3( C2, -C2, C2), SCNVector3( C2, -C2, -C2), SCNVector3( -C2, C2, C2), SCNVector3( -C2, C2, -C2), SCNVector3( -C2, -C2, C2), SCNVector3( -C2, -C2, -C2)]
    }
    
    public func generateFaces() -> [Int] {
        return [12, 0, 2 , 12, 2, 26 , 12, 26, 4 , 12, 4, 24 , 12, 24, 0 , 13, 3, 1 , 13, 1, 25 , 13, 25, 5 , 13, 5, 27 , 13, 27, 3 , 14, 2, 0 , 14, 0, 28 , 14, 28, 6 , 14, 6, 30 , 14, 30, 2 , 15, 1, 3 , 15, 3, 31 , 15, 31, 7 , 15, 7, 29 , 15, 29, 1 , 16, 4, 5 , 16, 5, 25 , 16, 25, 8 , 16, 8, 24 , 16, 24, 4 , 17, 5, 4 , 17, 4, 26 , 17, 26, 9 , 17, 9, 27 , 17, 27, 5 , 18, 7, 6 , 18, 6, 28 , 18, 28, 10 , 18, 10, 29 , 18, 29, 7 , 19, 6, 7 , 19, 7, 31 , 19, 31, 11 , 19, 11, 30 , 19, 30, 6 , 20, 8, 10 , 20, 10, 28 , 20, 28, 0 , 20, 0, 24 , 20, 24, 8 , 21, 10, 8 , 21, 8, 25 , 21, 25, 1 , 21, 1, 29 , 21, 29, 10 , 22, 11, 9 , 22, 9, 26 , 22, 26, 2 , 22, 2, 30 , 22, 30, 11 , 23, 9, 11 , 23, 11, 31 , 23, 31, 3 , 23, 3, 27 , 23, 27, 9]
    }
    
}
