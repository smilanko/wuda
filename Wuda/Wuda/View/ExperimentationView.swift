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
    
    @ObservedObject private var mapController = MapController.shared
    @ObservedObject private var motionController = MotionController.shared
    @ObservedObject private var logController = LogController.shared
    
    @State private var pointColor = Color(.sRGB, red: 122/255, green: 39/255, blue: 161/255)
    @State private var sphericalScene : SphericalScene = SphericalScene()
    @State private var exportFile = false
    @State private var motionFile : MotionDataFile?
    
    var body: some View {
        VStack {
            
            // controls
            HStack {
                HStack {
                    ColorPicker("Color", selection: $pointColor)
                    Button() {
                        pointColor = Color.random
                    } label: {
                        Text("Random")
                        Image(systemName: "wand.and.stars")
                    }
                    Button {
                        let currentUpdateState = motionController.pauseDataUpdates
                        if !currentUpdateState {
                            logController.log(type: .info, msg: "Pausing data updates while cleaning")
                            motionController.toggleUpdates()
                        }
                        // clear the sphere
                        sphericalScene.clearPoints()
                        // clear the face map
                        mapController.clearMap()
                        // clear the memory
                        motionController.clearMemory()
                        if motionController.pauseDataUpdates != currentUpdateState {
                            logController.log(type: .info, msg: "Cleanup complete. Enabling data updates")
                            motionController.toggleUpdates()
                        }
                    } label: {
                        Text("Clear Memory")
                        Image(systemName: "trash.square.fill").foregroundColor(.red)
                    }
                    Button {
                        motionController.toggleUpdates()
                    } label: {
                        Text(motionController.pauseDataUpdates ? "Resume" : "Pause")
                        Image(systemName: motionController.pauseDataUpdates ? "play.fill" : "pause.fill"  ).foregroundColor(motionController.pauseDataUpdates ? .green : .red)
                    }
                    Button {
                        let currentHistory = motionController.dataHistory
                        var closestFaces : [Int] = []
                        currentHistory.forEach({
                            closestFaces.append(sphericalScene.getClosestFaceToPoint(pt: SCNVector3Make($0.position.x, $0.position.y, $0.position.z)))
                        })
                        motionFile = MotionDataFile(allHistory: currentHistory, closestFace: closestFaces)
                        exportFile.toggle()
                    } label : {
                        Text("Export")
                        Image(systemName: "doc.circle.fill")
                    }
                }
            }.padding()

            // sphere with the points
            SphericalView(scene: sphericalScene).padding()
        }
        .onChange(of: pointColor, perform: { newColor in
            // when we change the color, we need to change the scene
            // the map will change by itself, since it binds to pointColor
            sphericalScene.updatePointColors(newColor: NSColor(newColor))
        })
        .onReceive(motionController.$positions, perform: { newPoints in
            // when we receive a new position form the motion controller,
            // we have to update the sphere ( 3d ), the angle ( 2d ), the map ( 1d )
            if let lastPoint = newPoints.last {
                let latestMotionPoint = SCNVector3Make(lastPoint.x, lastPoint.y, lastPoint.z)
                let closestFace = sphericalScene.getClosestFaceToPoint(pt: latestMotionPoint)
                sphericalScene.addPoint(latestPoint: latestMotionPoint, pointColor: pointColor)
                sphericalScene.addAngle(latestPoint: latestMotionPoint, angles: [lastPoint.xAngle, lastPoint.yAngle, lastPoint.zAngle])
                mapController.incrementFaceCount(faceId: closestFace)
            }
        })
        .fileExporter(isPresented: $exportFile, document: motionFile, contentType: .plainText, defaultFilename: motionController.activityName, onCompletion: { (result) in
            if case .success = result {
                logController.log(type: .info, msg: "Exported data file")
            } else {
                logController.log(type: .error, msg: "Cannot export data")
            }
        })
    }
    
}
