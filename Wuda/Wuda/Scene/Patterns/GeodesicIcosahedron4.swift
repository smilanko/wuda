//
//  GeodesicIcosahedron4.swift
//  Wuda
//
//  Found on an online source:
//  http://dmccooey.com/polyhedra/GeodesicIcosahedron4.html
//  A thank you to the author
//

import Foundation
import SceneKit

class GeodesicIcosahedron4 : Pattern {
    
    let C0  = 0.206011329583298282734862278122
    let C1  = 0.333333333333333333333333333333
    let C2  = 0.365011048475635682878683597149
    let C3  = 0.412022659166596565469724556244
    let C4  = 0.531481594704291835611964474359
    let C5  = 0.590600282702814029592933647918
    let C6  = 0.666666666666666666666666666667
    let C7  = 0.745355992499929898803057889577
    let C8  = 0.859955284626540309275373966959
    let C9  = 0.872677996249964949401528944789
    let C10 = 0.955611331178449712471617245067
    
    public func generateVertices() -> [SCNVector3] {
        return [SCNVector3( C0, 0.0, 1.0), SCNVector3( C0, 0.0, -1.0), SCNVector3( -C0, 0.0, 1.0), SCNVector3( -C0, 0.0, -1.0), SCNVector3( 1.0, C0, 0.0), SCNVector3( 1.0, -C0, 0.0), SCNVector3(-1.0, C0, 0.0), SCNVector3(-1.0, -C0, 0.0), SCNVector3( 0.0, 1.0, C0), SCNVector3( 0.0, 1.0, -C0), SCNVector3( 0.0, -1.0, C0), SCNVector3( 0.0, -1.0, -C0), SCNVector3( 0.0, C2, C10), SCNVector3( 0.0, C2, -C10), SCNVector3( 0.0, -C2, C10), SCNVector3( 0.0, -C2, -C10), SCNVector3( C10, 0.0, C2), SCNVector3( C10, 0.0, -C2), SCNVector3(-C10, 0.0, C2), SCNVector3(-C10, 0.0, -C2), SCNVector3( C2, C10, 0.0), SCNVector3( C2, -C10, 0.0), SCNVector3( -C2, C10, 0.0), SCNVector3( -C2, -C10, 0.0), SCNVector3( C3, C1, C9), SCNVector3( C3, C1, -C9), SCNVector3( C3, -C1, C9), SCNVector3( C3, -C1, -C9), SCNVector3( -C3, C1, C9), SCNVector3( -C3, C1, -C9), SCNVector3( -C3, -C1, C9), SCNVector3( -C3, -C1, -C9), SCNVector3( C9, C3, C1), SCNVector3( C9, C3, -C1), SCNVector3( C9, -C3, C1), SCNVector3( C9, -C3, -C1), SCNVector3( -C9, C3, C1), SCNVector3( -C9, C3, -C1), SCNVector3( -C9, -C3, C1), SCNVector3( -C9, -C3, -C1), SCNVector3( C1, C9, C3), SCNVector3( C1, C9, -C3), SCNVector3( C1, -C9, C3), SCNVector3( C1, -C9, -C3), SCNVector3( -C1, C9, C3), SCNVector3( -C1, C9, -C3), SCNVector3( -C1, -C9, C3), SCNVector3( -C1, -C9, -C3), SCNVector3( C4, 0.0, C8), SCNVector3( C4, 0.0, -C8), SCNVector3( -C4, 0.0, C8), SCNVector3( -C4, 0.0, -C8), SCNVector3( C8, C4, 0.0), SCNVector3( C8, -C4, 0.0), SCNVector3( -C8, C4, 0.0), SCNVector3( -C8, -C4, 0.0), SCNVector3( 0.0, C8, C4), SCNVector3( 0.0, C8, -C4), SCNVector3( 0.0, -C8, C4), SCNVector3( 0.0, -C8, -C4), SCNVector3( C0, C6, C7), SCNVector3( C0, C6, -C7), SCNVector3( C0, -C6, C7), SCNVector3( C0, -C6, -C7), SCNVector3( -C0, C6, C7), SCNVector3( -C0, C6, -C7), SCNVector3( -C0, -C6, C7), SCNVector3( -C0, -C6, -C7), SCNVector3( C7, C0, C6), SCNVector3( C7, C0, -C6), SCNVector3( C7, -C0, C6), SCNVector3( C7, -C0, -C6), SCNVector3( -C7, C0, C6), SCNVector3( -C7, C0, -C6), SCNVector3( -C7, -C0, C6), SCNVector3( -C7, -C0, -C6), SCNVector3( C6, C7, C0), SCNVector3( C6, C7, -C0), SCNVector3( C6, -C7, C0), SCNVector3( C6, -C7, -C0), SCNVector3( -C6, C7, C0), SCNVector3( -C6, C7, -C0), SCNVector3( -C6, -C7, C0), SCNVector3( -C6, -C7, -C0), SCNVector3( C5, C5, C5), SCNVector3( C5, C5, -C5), SCNVector3( C5, -C5, C5), SCNVector3( C5, -C5, -C5), SCNVector3( -C5, C5, C5), SCNVector3( -C5, C5, -C5), SCNVector3( -C5, -C5, C5), SCNVector3( -C5, -C5, -C5)]
    }
    
    public func generateFaces() -> [Int] {
        return [12, 0, 24 , 12, 24, 60 , 12, 60, 64 , 12, 64, 28 , 12, 28, 2 , 12, 2, 0 , 13, 3, 29 , 13, 29, 65 , 13, 65, 61 , 13, 61, 25 , 13, 25, 1 , 13, 1, 3 , 14, 2, 30 , 14, 30, 66 , 14, 66, 62 , 14, 62, 26 , 14, 26, 0 , 14, 0, 2 , 15, 1, 27 , 15, 27, 63 , 15, 63, 67 , 15, 67, 31 , 15, 31, 3 , 15, 3, 1 , 16, 4, 32 , 16, 32, 68 , 16, 68, 70 , 16, 70, 34 , 16, 34, 5 , 16, 5, 4 , 17, 5, 35 , 17, 35, 71 , 17, 71, 69 , 17, 69, 33 , 17, 33, 4 , 17, 4, 5 , 18, 7, 38 , 18, 38, 74 , 18, 74, 72 , 18, 72, 36 , 18, 36, 6 , 18, 6, 7 , 19, 6, 37 , 19, 37, 73 , 19, 73, 75 , 19, 75, 39 , 19, 39, 7 , 19, 7, 6 , 20, 8, 40 , 20, 40, 76 , 20, 76, 77 , 20, 77, 41 , 20, 41, 9 , 20, 9, 8 , 21, 11, 43 , 21, 43, 79 , 21, 79, 78 , 21, 78, 42 , 21, 42, 10 , 21, 10, 11 , 22, 9, 45 , 22, 45, 81 , 22, 81, 80 , 22, 80, 44 , 22, 44, 8 , 22, 8, 9 , 23, 10, 46 , 23, 46, 82 , 23, 82, 83 , 23, 83, 47 , 23, 47, 11 , 23, 11, 10 , 84, 24, 68 , 84, 68, 32 , 84, 32, 76 , 84, 76, 40 , 84, 40, 60 , 84, 60, 24 , 85, 25, 61 , 85, 61, 41 , 85, 41, 77 , 85, 77, 33 , 85, 33, 69 , 85, 69, 25 , 86, 26, 62 , 86, 62, 42 , 86, 42, 78 , 86, 78, 34 , 86, 34, 70 , 86, 70, 26 , 87, 27, 71 , 87, 71, 35 , 87, 35, 79 , 87, 79, 43 , 87, 43, 63 , 87, 63, 27 , 88, 28, 64 , 88, 64, 44 , 88, 44, 80 , 88, 80, 36 , 88, 36, 72 , 88, 72, 28 , 89, 29, 73 , 89, 73, 37 , 89, 37, 81 , 89, 81, 45 , 89, 45, 65 , 89, 65, 29 , 90, 30, 74 , 90, 74, 38 , 90, 38, 82 , 90, 82, 46 , 90, 46, 66 , 90, 66, 30 , 91, 31, 67 , 91, 67, 47 , 91, 47, 83 , 91, 83, 39 , 91, 39, 75 , 91, 75, 31 , 48, 0, 26 , 48, 26, 70 , 48, 70, 68 , 48, 68, 24 , 48, 24, 0 , 49, 1, 25 , 49, 25, 69 , 49, 69, 71 , 49, 71, 27 , 49, 27, 1 , 50, 2, 28 , 50, 28, 72 , 50, 72, 74 , 50, 74, 30 , 50, 30, 2 , 51, 3, 31 , 51, 31, 75 , 51, 75, 73 , 51, 73, 29 , 51, 29, 3 , 52, 4, 33 , 52, 33, 77 , 52, 77, 76 , 52, 76, 32 , 52, 32, 4 , 53, 5, 34 , 53, 34, 78 , 53, 78, 79 , 53, 79, 35 , 53, 35, 5 , 54, 6, 36 , 54, 36, 80 , 54, 80, 81 , 54, 81, 37 , 54, 37, 6 , 55, 7, 39 , 55, 39, 83 , 55, 83, 82 , 55, 82, 38 , 55, 38, 7 , 56, 8, 44 , 56, 44, 64 , 56, 64, 60 , 56, 60, 40 , 56, 40, 8 , 57, 9, 41 , 57, 41, 61 , 57, 61, 65 , 57, 65, 45 , 57, 45, 9 , 58, 10, 42 , 58, 42, 62 , 58, 62, 66 , 58, 66, 46 , 58, 46, 10 , 59, 11, 47 , 59, 47, 67 , 59, 67, 63 , 59, 63, 43 , 59, 43, 11]
    }
    
}
