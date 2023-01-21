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
    
    @State private var pointColor = Color(.sRGB, red: 122/255, green: 39/255, blue: 161/255)
    @State private var sphericalScene : SphericalScene = SphericalScene(isoPattern: .geodasicPattern4)
    @State private var rows : [GridItem] = []
    @State private var faces : [FaceOnMap] = []
    @State private var exportFile = false
    @State private var motionFile : MotionDataFile?
    
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
                        let currentUpdateState = motionController.pauseDataUpdates
                        if !currentUpdateState {
                            logController.addLogMessage(type: .info, msg: "Pausing data updates while cleaning")
                            motionController.toggleUpdates()
                        }
                        // clear the sphere
                        sphericalScene.clearPoints()
                        // clear the face map
                        faces.forEach({ entry in
                            faces[entry.id].count = 0
                        })
                        // clear the memory
                        motionController.clearMemory()
                        if motionController.pauseDataUpdates != currentUpdateState {
                            logController.addLogMessage(type: .info, msg: "Cleanup complete. Enabling data updates")
                            motionController.toggleUpdates()
                        }
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
                    Button {
                        motionFile = MotionDataFile(allHistory: motionController.dataHistory)
                        exportFile.toggle()
                    } label : {
                        Text("Export")
                        Image(systemName: "doc.circle.fill")
                    }
                }
            }.padding()

            // sphere with the points
            SphericalView(scene: sphericalScene).padding()
            
            // map of faces
            let totalEntries = Double(faces.filter({ $0.count > 0 }).count)
            LazyHGrid(rows: rows, alignment: .center, spacing: 0, pinnedViews: [], content: {
                ForEach(faces) { face in
                    ZStack {
                        Square(color: pointColor.opacity(face.count / totalEntries )).border(.black.opacity(0.2))
                        Text("\(face.id)").opacity(0.7)
                    }
                }.background(Color(Constants.atmosphereColor).opacity(0.15))
            }).padding().frame(maxWidth: .infinity)

            // logs
            LogView {
                List(logController.logMessages) { logMsg in
                    Text(logMsg.id.isoDate + " " + logMsg.type.rawValue + " " + logMsg.msg)
                }
            }.padding()
            
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
                faces[closestFace].count += 1
            }
        })
        .onAppear {
            // build the number of faces for our 1d map
            for idx in 0..<sphericalScene.getTotalFaces() {
                faces.append(FaceOnMap(id: idx, count: 0))
            }
            // build the map using a grid system
            for _ in 0..<(sphericalScene.getTotalFaces() / 20) {
                rows.append(GridItem(.fixed(Constants.squareSize), spacing: 0, alignment: .center))
            }
        }
        .fileExporter(isPresented: $exportFile, document: motionFile, contentType: .plainText, defaultFilename: "wuda_barbell_curls", onCompletion: { (result) in
            if case .success = result {
                logController.addLogMessage(type: .info, msg: "Exported data file")
            } else {
                logController.addLogMessage(type: .error, msg: "Cannot export data")
            }
        })
    }
    
}
