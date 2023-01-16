//
//  Pattern.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SceneKit

protocol Pattern {
    
    func generateVertices() -> [SCNVector3]
    func generateFaces() -> [Int]
    
}
