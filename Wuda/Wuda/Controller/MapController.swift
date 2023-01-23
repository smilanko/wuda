//
//  MapController.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI
import simd


class MapController: ObservableObject {
 
    @Published public var rows : [GridItem] = []
    @Published public var faces : [FaceOnMap] = []
    
    public static var shared = MapController()
    
    private init() {
        let totalFaces = Constants.defaultGeodasicPattern.rawValue
        for idx in 0..<totalFaces {
            faces.append(FaceOnMap(id: idx, count: 0))
        }
        // build the map using a grid system
        for _ in 0..<(totalFaces / 20) {
            rows.append(GridItem(.fixed(Constants.squareSize), spacing: 0, alignment: .center))
        }
    }
    
    public func clearMap() {
        faces.forEach({ entry in
            faces[entry.id].count = 0
        })
    }
    
    public func incrementFaceCount(faceId: Int) {
        faces[faceId].count += 1
    }
    
    public func addRow() {
        rows.append(GridItem(.fixed(Constants.squareSize), spacing: 0, alignment: .center))
    }
    
}
