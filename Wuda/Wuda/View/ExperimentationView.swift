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
    @State private var closestFace : Int = -1

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
                        faces.forEach({ entry in
                            faces[entry.id].count = 0
                        })
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
            // the sphere
            SphericalView(scene: sphericalScene)
            
            // the map
            let totalEntries = Double(faces.filter({ $0.count > 0 }).count)
            LazyHGrid(rows: rows, alignment: .center, spacing: 0, pinnedViews: [], content: {
                ForEach(faces) { face in
                    ZStack {
                        Square(color: pointColor.opacity(face.count / totalEntries )).border(.black.opacity(0.2))
                        Text("\(face.id)").opacity(0.2)
                    }
                }.background(Color(Constants.atmosphereColor.withAlphaComponent(0.15)))
            }).frame(maxWidth: .infinity)

            // log views
            LogView {
                List(logController.logMessages) { logMsg in
                    Text(logMsg.id.isoDate + " " + logMsg.type.rawValue + " " + logMsg.msg)
                }
            }.padding()
            
        }
        .onChange(of: pointColor, perform: { newColor in
            sphericalScene.updatePointColors(newColor: NSColor(newColor))
        })
        .onReceive(motionController.$positions, perform: { newPoints in
            if let lastPoint = newPoints.last {
                let latestMotionPoint = SCNVector3Make(lastPoint.x, lastPoint.y, lastPoint.z)
                closestFace = sphericalScene.getClosestFaceToPoint(pt: latestMotionPoint)
                sphericalScene.addPoint(latestPoint: latestMotionPoint, pointColor: pointColor)
                faces[closestFace].count += 1
            }
        })
        .onAppear {
            for idx in 0..<sphericalScene.getTotalFaces() {
                faces.append(FaceOnMap(id: idx, count: 0))
            }
            for _ in 0..<(sphericalScene.getTotalFaces() / 20) {
                rows.append(GridItem(.fixed(Constants.squareSize), spacing: 0, alignment: .center))
            }
        }
    }
    
}
