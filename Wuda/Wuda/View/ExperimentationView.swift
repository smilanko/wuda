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
    
    @ObservedObject private var motionController = MotionController.shared
    @ObservedObject private var logController = LogController.shared
    
    @State private var sphericalScene : SphericalScene = SphericalScene(isoPattern: .geodasicPattern8)
    @State private var centerPointsOnGeodesicIcosahedron : [Int: SCNVector3] = [:]
    @State private var anglePlaneIdx : Double = 0.0
    @State private var pointColor = Color(.sRGB, red: 122/255, green: 39/255, blue: 161/255)
    @State private var clearScatterPlot: Bool = true
    @State private var closestFace : Int = -1
    
    private let gradient = Gradient(colors: [ Color(Constants.gradientStartColor), Color(Constants.gradientEndColor) ])
    
    var body: some View {
        VStack {
            // controls
            HStack {
                HStack {
                    ColorPicker("Point Color", selection: $pointColor)
                    Button() {
                        pointColor = Color.random
                    } label: {
                        Text("Random")
                        Image(systemName: "wand.and.stars")
                    }
                    Button {
                        sphericalScene.clearPoints()
                        clearScatterPlot.toggle()
                    } label: {
                        Text("Clear Points")
                        Image(systemName: "trash.square.fill").foregroundColor(.red)
                    }
                    Button {
                        motionController.toggleUpdates()
                    } label: {
                        Text(motionController.pauseDataUpdates ? "Resume" : "Pause")
                        Image(systemName: motionController.pauseDataUpdates ? "flag.circle.fill" : "stop.circle.fill"  ).foregroundColor(motionController.pauseDataUpdates ? .green : .red)
                    }
                }
            }.padding()
            // visuals
            SphericalView(scene: sphericalScene)
            
            HStack {
                // log views
                LogView {
                    List(logController.logMessages) { logMsg in
                        Text(logMsg.id.isoDate + " " + logMsg.type.rawValue + " " + logMsg.msg)
                    }
                }
                // position on map
                (Text("(x+👉, y+👆, z-🫵)") + Text("\tCurrent Position: ") + Text("\(closestFace)").foregroundColor(.red))
            }.padding()
        }.onReceive(motionController.$positions, perform: { newPoints in
            if let lastPoint = newPoints.last {
                let latestMotionPoint = SCNVector3Make(lastPoint.x, lastPoint.y, lastPoint.z)
                closestFace = sphericalScene.getClosestFaceToPoint(pt: latestMotionPoint)
                sphericalScene.addPoint(latestPoint: latestMotionPoint, pointColor: pointColor)
            }
        })
    }
    
}
