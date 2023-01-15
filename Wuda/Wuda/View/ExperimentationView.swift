//
//  SceneView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI
import SceneKit

struct ExperimentationView: View {
    
    @ObservedObject private var experimentState = ExperimentState.shared
    
    @State private var sphericalScene : SphericalScene = SphericalScene()
    @State private var centerPointsOnGeodesicIcosahedron : [Int: SCNVector3] = [:]
    @State private var anglePlaneIdx : Double = 0.0

    let colors : [Color] = [Color.red, Color.blue, Color.orange]
    
    var body: some View {
        VStack {
            // controls
            HStack {
                HStack {
                    ColorPicker("Point Color", selection: $experimentState.pointColor)
                    Button {
                        sphericalScene.clearPoints()
                        experimentState.clearScatterPlot.toggle()
                    } label: {
                        Text("Clear")
                        Image(systemName: "trash.square.fill").foregroundColor(.red)
                    }
                    Button {
                        experimentState.canUpdatePoints.toggle()
                    } label: {
                        let isRunning = experimentState.canUpdatePoints
                        Image(systemName: isRunning ? "stop.circle.fill" : "flag.circle.fill" ).foregroundColor(isRunning ? .red : .green)
                    }
                }
            }.padding()
            // visuals
            SphericalView(centerPointsOnGeodesicIcosahedron: centerPointsOnGeodesicIcosahedron, scene: sphericalScene)
            HStack {
                LogView {
                    List(experimentState.logMessages) { logMsg in
                        Text(logMsg.id.isoDate() + " " + logMsg.type.rawValue + " " + logMsg.msg)
                    }
                }
                PositionMap {
                    List(experimentState.positionsOnMap) { pt in
                        Text(pt.id.isoDate() + " \(pt.position)")
                    }
                }
            }.padding()
        }
    }
    
    private func getChildrenFromScene() {
        // prepare the centers
        if let geodesicIcosahedron = sphericalScene.rootNode.childNodes.first(where: { $0.name == WudaConstants.rootNodeForGeodasicMap }) {
            let geoChildren = geodesicIcosahedron.childNodes
            for mapEntry in stride(from: 0, to:geoChildren.count, by: 3) {
                let nodeOfInterest = geoChildren[mapEntry + 2]
                if let nodeName = nodeOfInterest.name, let faceId = Int(nodeName) {
                    centerPointsOnGeodesicIcosahedron[faceId] = nodeOfInterest.position
                } else {
                    experimentState.addLogMessage(type: .error, msg: "Could not find the center of a face")
                }
            }
        }
    }
    
}
