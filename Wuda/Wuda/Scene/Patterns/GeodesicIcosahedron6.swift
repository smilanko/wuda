//
//  GeodesicIcosahedron6.swift
//  Wuda
//
//  Found on an online source:
//  http://dmccooey.com/polyhedra/GeodesicIcosahedron6.html
//  A thank you to the author
//

import Foundation
import SceneKit

class GeodesicIcosahedron6 : Pattern {
    
    let C0 = 0.0490292290809816813559980717806
    let C1 = 0.0811537993242050291283007970286
    let C2 = 0.0937079220984928965528680897233
    let C3 = 0.147092881929040214212477146562
    let C4 = 0.1698474801652096000762210461251
    let C5 = 0.196122111010021895568475218343
    let C6 = 0.225017527721244880788439023943
    let C7 = 0.232776402294693907345025983908
    let C8 = 0.281133694724888181438483705599
    let C9 = 0.282932208593240862452296121099
    let C10 = 0.374841616823381077991351795322
    let C11 = 0.407848762629571865256962548230
    let C12 = 0.421911877739872952636111616023
    let C13 = 0.470941106820854633992109687803
    let C14 = 0.487179721724804996395624028434
    let C15 = 0.506151222446133062226922729541
    let C16 = 0.512820278275195003604375971566
    let C17 = 0.529418476297024915608418394146
    let C18 = 0.592151237370428134743037451770
    let C19 = 0.657773825416621940443647916421
    let C20 = 0.6876602757424000037429180280249
    let C21 = 0.708942389285216899172851189909
    let C22 = 0.737816082040946958850188165216
    let C23 = 0.738927624740826969571948713449
    let C24 = 0.739244119299468348955514598332
    let C25 = 0.831524004139439855403056254939
    let C26 = 0.856617088920766884656713812714996
    let C27 = 0.878789869450426499249072236034
    let C28 = 0.909091599464677949031735644457
    let C29 = 0.912677803463644884531357051967
    let C30 = 0.970592484335640866195214149124
    
    public func generateVertices() -> [SCNVector3] {
        return [SCNVector3( C0, -C4, 1.0), SCNVector3( C0, C4, -1.0), SCNVector3( -C0, C4, 1.0), SCNVector3( -C0, -C4, -1.0), SCNVector3( 1.0, -C0, C4), SCNVector3( 1.0, C0, -C4), SCNVector3(-1.0, C0, C4), SCNVector3(-1.0, -C0, -C4), SCNVector3( C4, -1.0, C0), SCNVector3( C4, 1.0, -C0), SCNVector3( -C4, 1.0, C0), SCNVector3( -C4, -1.0, -C0), SCNVector3( C8, C1, C30), SCNVector3( C8, -C1, -C30), SCNVector3( -C8, -C1, C30), SCNVector3( -C8, C1, -C30), SCNVector3( C30, C8, C1), SCNVector3( C30, -C8, -C1), SCNVector3(-C30, -C8, C1), SCNVector3(-C30, C8, -C1), SCNVector3( C1, C30, C8), SCNVector3( C1, -C30, -C8), SCNVector3( -C1, -C30, C8), SCNVector3( -C1, C30, -C8), SCNVector3( C10, -C7, C29), SCNVector3( C10, C7, -C29), SCNVector3(-C10, C7, C29), SCNVector3(-C10, -C7, -C29), SCNVector3( C29, -C10, C7), SCNVector3( C29, C10, -C7), SCNVector3(-C29, C10, C7), SCNVector3(-C29, -C10, -C7), SCNVector3( C7, -C29, C10), SCNVector3( C7, C29, -C10), SCNVector3( -C7, C29, C10), SCNVector3( -C7, -C29, -C10), SCNVector3( C5, C11, C28), SCNVector3( C5, -C11, -C28), SCNVector3( -C5, -C11, C28), SCNVector3( -C5, C11, -C28), SCNVector3( C28, C5, C11), SCNVector3( C28, -C5, -C11), SCNVector3(-C28, -C5, C11), SCNVector3(-C28, C5, -C11), SCNVector3( C11, C28, C5), SCNVector3( C11, -C28, -C5), SCNVector3(-C11, -C28, C5), SCNVector3(-C11, C28, -C5), SCNVector3( C3, -C14, C27), SCNVector3( C3, C14, -C27), SCNVector3( -C3, C14, C27), SCNVector3( -C3, -C14, -C27), SCNVector3( C27, -C3, C14), SCNVector3( C27, C3, -C14), SCNVector3(-C27, C3, C14), SCNVector3(-C27, -C3, -C14), SCNVector3( C14, -C27, C3), SCNVector3( C14, C27, -C3), SCNVector3(-C14, C27, C3), SCNVector3(-C14, -C27, -C3), SCNVector3( C17, 0.0, C26), SCNVector3( C17, 0.0, -C26), SCNVector3(-C17, 0.0, C26), SCNVector3(-C17, 0.0, -C26), SCNVector3( C26, C17, 0.0), SCNVector3( C26, -C17, 0.0), SCNVector3(-C26, C17, 0.0), SCNVector3(-C26, -C17, 0.0), SCNVector3( 0.0, C26, C17), SCNVector3( 0.0, C26, -C17), SCNVector3( 0.0, -C26, C17), SCNVector3( 0.0, -C26, -C17), SCNVector3( C15, C9, C25), SCNVector3( C15, -C9, -C25), SCNVector3(-C15, -C9, C25), SCNVector3(-C15, C9, -C25), SCNVector3( C25, C15, C9), SCNVector3( C25, -C15, -C9), SCNVector3(-C25, -C15, C9), SCNVector3(-C25, C15, -C9), SCNVector3( C9, C25, C15), SCNVector3( C9, -C25, -C15), SCNVector3( -C9, -C25, C15), SCNVector3( -C9, C25, -C15), SCNVector3( C13, -C16, C24), SCNVector3( C13, C16, -C24), SCNVector3(-C13, C16, C24), SCNVector3(-C13, -C16, -C24), SCNVector3( C24, -C13, C16), SCNVector3( C24, C13, -C16), SCNVector3(-C24, C13, C16), SCNVector3(-C24, -C13, -C16), SCNVector3( C16, -C24, C13), SCNVector3( C16, C24, -C13), SCNVector3(-C16, C24, C13), SCNVector3(-C16, -C24, -C13), SCNVector3( C2, C20, C23), SCNVector3( C2, -C20, -C23), SCNVector3( -C2, -C20, C23), SCNVector3( -C2, C20, -C23), SCNVector3( C23, C2, C20), SCNVector3( C23, -C2, -C20), SCNVector3(-C23, -C2, C20), SCNVector3(-C23, C2, -C20), SCNVector3( C20, C23, C2), SCNVector3( C20, -C23, -C2), SCNVector3(-C20, -C23, C2), SCNVector3(-C20, C23, -C2), SCNVector3( C19, -C6, C22), SCNVector3( C19, C6, -C22), SCNVector3(-C19, C6, C22), SCNVector3(-C19, -C6, -C22), SCNVector3( C22, -C19, C6), SCNVector3( C22, C19, -C6), SCNVector3(-C22, C19, C6), SCNVector3(-C22, -C19, -C6), SCNVector3( C6, -C22, C19), SCNVector3( C6, C22, -C19), SCNVector3( -C6, C22, C19), SCNVector3( -C6, -C22, -C19), SCNVector3( C12, C18, C21), SCNVector3( C12, -C18, -C21), SCNVector3(-C12, -C18, C21), SCNVector3(-C12, C18, -C21), SCNVector3( C21, C12, C18), SCNVector3( C21, -C12, -C18), SCNVector3(-C21, -C12, C18), SCNVector3(-C21, C12, -C18), SCNVector3( C18, C21, C12), SCNVector3( C18, -C21, -C12), SCNVector3(-C18, -C21, C12), SCNVector3(-C18, C21, -C12)]
    }
    
    public func generateFaces() -> [Int] {
        return [60, 12, 24 , 60, 24, 108 , 60, 108, 100 , 60, 100, 72 , 60, 72, 12 , 61, 13, 25 , 61, 25, 109 , 61, 109, 101 , 61, 101, 73 , 61, 73, 13 , 62, 14, 26 , 62, 26, 110 , 62, 110, 102 , 62, 102, 74 , 62, 74, 14 , 63, 15, 27 , 63, 27, 111 , 63, 111, 103 , 63, 103, 75 , 63, 75, 15 , 64, 16, 29 , 64, 29, 113 , 64, 113, 104 , 64, 104, 76 , 64, 76, 16 , 65, 17, 28 , 65, 28, 112 , 65, 112, 105 , 65, 105, 77 , 65, 77, 17 , 66, 19, 30 , 66, 30, 114 , 66, 114, 107 , 66, 107, 79 , 66, 79, 19 , 67, 18, 31 , 67, 31, 115 , 67, 115, 106 , 67, 106, 78 , 67, 78, 18 , 68, 20, 34 , 68, 34, 118 , 68, 118, 96 , 68, 96, 80 , 68, 80, 20 , 69, 23, 33 , 69, 33, 117 , 69, 117, 99 , 69, 99, 83 , 69, 83, 23 , 70, 22, 32 , 70, 32, 116 , 70, 116, 98 , 70, 98, 82 , 70, 82, 22 , 71, 21, 35 , 71, 35, 119 , 71, 119, 97 , 71, 97, 81 , 71, 81, 21 , 12, 72, 36 , 12, 36, 2 , 12, 2, 0 , 13, 73, 37 , 13, 37, 3 , 13, 3, 1 , 14, 74, 38 , 14, 38, 0 , 14, 0, 2 , 15, 75, 39 , 15, 39, 1 , 15, 1, 3 , 16, 76, 40 , 16, 40, 4 , 16, 4, 5 , 17, 77, 41 , 17, 41, 5 , 17, 5, 4 , 18, 78, 42 , 18, 42, 6 , 18, 6, 7 , 19, 79, 43 , 19, 43, 7 , 19, 7, 6 , 20, 80, 44 , 20, 44, 9 , 20, 9, 10 , 21, 81, 45 , 21, 45, 8 , 21, 8, 11 , 22, 82, 46 , 22, 46, 11 , 22, 11, 8 , 23, 83, 47 , 23, 47, 10 , 23, 10, 9 , 24, 12, 0 , 24, 0, 48 , 24, 48, 84 , 25, 13, 1 , 25, 1, 49 , 25, 49, 85 , 26, 14, 2 , 26, 2, 50 , 26, 50, 86 , 27, 15, 3 , 27, 3, 51 , 27, 51, 87 , 28, 17, 4 , 28, 4, 52 , 28, 52, 88 , 29, 16, 5 , 29, 5, 53 , 29, 53, 89 , 30, 19, 6 , 30, 6, 54 , 30, 54, 90 , 31, 18, 7 , 31, 7, 55 , 31, 55, 91 , 32, 22, 8 , 32, 8, 56 , 32, 56, 92 , 33, 23, 9 , 33, 9, 57 , 33, 57, 93 , 34, 20, 10 , 34, 10, 58 , 34, 58, 94 , 35, 21, 11 , 35, 11, 59 , 35, 59, 95 , 72, 100, 124 , 72, 124, 120 , 72, 120, 36 , 73, 101, 125 , 73, 125, 121 , 73, 121, 37 , 74, 102, 126 , 74, 126, 122 , 74, 122, 38 , 75, 103, 127 , 75, 127, 123 , 75, 123, 39 , 76, 104, 128 , 76, 128, 124 , 76, 124, 40 , 77, 105, 129 , 77, 129, 125 , 77, 125, 41 , 78, 106, 130 , 78, 130, 126 , 78, 126, 42 , 79, 107, 131 , 79, 131, 127 , 79, 127, 43 , 80, 96, 120 , 80, 120, 128 , 80, 128, 44 , 81, 97, 121 , 81, 121, 129 , 81, 129, 45 , 82, 98, 122 , 82, 122, 130 , 82, 130, 46 , 83, 99, 123 , 83, 123, 131 , 83, 131, 47 , 96, 118, 50 , 96, 50, 36 , 96, 36, 120 , 97, 119, 51 , 97, 51, 37 , 97, 37, 121 , 98, 116, 48 , 98, 48, 38 , 98, 38, 122 , 99, 117, 49 , 99, 49, 39 , 99, 39, 123 , 100, 108, 52 , 100, 52, 40 , 100, 40, 124 , 101, 109, 53 , 101, 53, 41 , 101, 41, 125 , 102, 110, 54 , 102, 54, 42 , 102, 42, 126 , 103, 111, 55 , 103, 55, 43 , 103, 43, 127 , 104, 113, 57 , 104, 57, 44 , 104, 44, 128 , 105, 112, 56 , 105, 56, 45 , 105, 45, 129 , 106, 115, 59 , 106, 59, 46 , 106, 46, 130 , 107, 114, 58 , 107, 58, 47 , 107, 47, 131 , 108, 24, 84 , 108, 84, 88 , 108, 88, 52 , 109, 25, 85 , 109, 85, 89 , 109, 89, 53 , 110, 26, 86 , 110, 86, 90 , 110, 90, 54 , 111, 27, 87 , 111, 87, 91 , 111, 91, 55 , 112, 28, 88 , 112, 88, 92 , 112, 92, 56 , 113, 29, 89 , 113, 89, 93 , 113, 93, 57 , 114, 30, 90 , 114, 90, 94 , 114, 94, 58 , 115, 31, 91 , 115, 91, 95 , 115, 95, 59 , 116, 32, 92 , 116, 92, 84 , 116, 84, 48 , 117, 33, 93 , 117, 93, 85 , 117, 85, 49 , 118, 34, 94 , 118, 94, 86 , 118, 86, 50 , 119, 35, 95 , 119, 95, 87 , 119, 87, 51 , 0, 38, 48 , 1, 39, 49 , 2, 36, 50 , 3, 37, 51 , 4, 40, 52 , 5, 41, 53 , 6, 42, 54 , 7, 43, 55 , 8, 45, 56 , 9, 44, 57 , 10, 47, 58 , 11, 46, 59 , 84, 92, 88 , 85, 93, 89 , 86, 94, 90 , 87, 95, 91 , 120, 124, 128 , 121, 125, 129 , 122, 126, 130 , 123, 127, 131]
    }
    
}
