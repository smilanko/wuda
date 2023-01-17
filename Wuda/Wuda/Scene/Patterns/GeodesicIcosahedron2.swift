//
//  GeodesicIcosahedron2.swift
//  Wuda
//
//  Found on an online source:
//  http://dmccooey.com/polyhedra/GeodesicIcosahedron2.html
//  A thank you to the author
//

import Foundation
import SceneKit

class GeodesicIcosahedron2 : Pattern {
    
    let C0 = 0.3249196962329063261558714122151
    let C1 = 0.525731112119133606025669084848
    let C2 = 0.541166900871121200823328817258
    let C3 = 0.850650808352039932181540497063
    let C4 = 0.875626439195919181581615733217
    let C5 = 1.05146222423826721205133816970
    
    public func generateVertices() -> [SCNVector3] {
        return [SCNVector3(0.0, 0.0, C5), SCNVector3(0.0, 0.0, -C5), SCNVector3( C5, 0.0, 0.0), SCNVector3(-C5, 0.0, 0.0), SCNVector3(0.0, C5, 0.0), SCNVector3(0.0, -C5, 0.0), SCNVector3( C2, 0.0, C4), SCNVector3( C2, 0.0, -C4), SCNVector3(-C2, 0.0, C4), SCNVector3(-C2, 0.0, -C4), SCNVector3( C4, C2, 0.0), SCNVector3( C4, -C2, 0.0), SCNVector3(-C4, C2, 0.0), SCNVector3(-C4, -C2, 0.0), SCNVector3(0.0, C4, C2), SCNVector3(0.0, C4, -C2), SCNVector3(0.0, -C4, C2), SCNVector3(0.0, -C4, -C2), SCNVector3( C0, C1, C3), SCNVector3( C0, C1, -C3), SCNVector3( C0, -C1, C3), SCNVector3( C0, -C1, -C3), SCNVector3(-C0, C1, C3), SCNVector3(-C0, C1, -C3), SCNVector3(-C0, -C1, C3), SCNVector3(-C0, -C1, -C3), SCNVector3( C3, C0, C1), SCNVector3( C3, C0, -C1), SCNVector3( C3, -C0, C1), SCNVector3( C3, -C0, -C1), SCNVector3(-C3, C0, C1), SCNVector3(-C3, C0, -C1), SCNVector3(-C3, -C0, C1), SCNVector3(-C3, -C0, -C1), SCNVector3( C1, C3, C0), SCNVector3( C1, C3, -C0), SCNVector3( C1, -C3, C0), SCNVector3( C1, -C3, -C0), SCNVector3(-C1, C3, C0), SCNVector3(-C1, C3, -C0), SCNVector3(-C1, -C3, C0), SCNVector3(-C1, -C3, -C0)]
    }
    
    public func generateFaces() -> [Int] {
        return [6, 0, 20 , 6, 20, 28 , 6, 28, 26 , 6, 26, 18 , 6, 18, 0 , 7, 1, 19 , 7, 19, 27 , 7, 27, 29 , 7, 29, 21 , 7, 21, 1 , 8, 0, 22 , 8, 22, 30 , 8, 30, 32 , 8, 32, 24 , 8, 24, 0 , 9, 1, 25 , 9, 25, 33 , 9, 33, 31 , 9, 31, 23 , 9, 23, 1 , 10, 2, 27 , 10, 27, 35 , 10, 35, 34 , 10, 34, 26 , 10, 26, 2 , 11, 2, 28 , 11, 28, 36 , 11, 36, 37 , 11, 37, 29 , 11, 29, 2 , 12, 3, 30 , 12, 30, 38 , 12, 38, 39 , 12, 39, 31 , 12, 31, 3 , 13, 3, 33 , 13, 33, 41 , 13, 41, 40 , 13, 40, 32 , 13, 32, 3 , 14, 4, 38 , 14, 38, 22 , 14, 22, 18 , 14, 18, 34 , 14, 34, 4 , 15, 4, 35 , 15, 35, 19 , 15, 19, 23 , 15, 23, 39 , 15, 39, 4 , 16, 5, 36 , 16, 36, 20 , 16, 20, 24 , 16, 24, 40 , 16, 40, 5 , 17, 5, 41 , 17, 41, 25 , 17, 25, 21 , 17, 21, 37 , 17, 37, 5 , 0, 18, 22 , 0, 24, 20 , 1, 21, 25 , 1, 23, 19 , 2, 26, 28 , 2, 29, 27 , 3, 31, 33 , 3, 32, 30 , 4, 34, 35 , 4, 39, 38 , 5, 37, 36 , 5, 40, 41 , 18, 26, 34 , 19, 35, 27 , 20, 36, 28 , 21, 29, 37 , 22, 38, 30 , 23, 31, 39 , 24, 32, 40 , 25, 41, 33]
    }
    
}
