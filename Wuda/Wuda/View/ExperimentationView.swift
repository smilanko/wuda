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
    @State private var xShift : Double = 0.0
    @State private var yShift : Double = 0.0
    @State private var zShift : Double = 0.0
    
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

            // quaternions
            HStack {
                Text("shift = ( ")
                Stepper(value: $xShift, in: 0...360) { Text("x:\(Int(xShift)),") }.disabled( yShift > 0 || zShift > 0)
                Stepper(value: $yShift, in: 0...360) { Text("y:\(Int(yShift)),") }.disabled( xShift > 0 || zShift > 0)
                Stepper(value: $zShift, in: 0...360) { Text("z:\(Int(zShift))") }.disabled( xShift > 0 || yShift > 0)
                Text(" )")
            }
            // the sphere
            SphericalView(scene: sphericalScene).padding()
            
            // the map
            let totalEntries = Double(faces.filter({ $0.count > 0 }).count)
            LazyHGrid(rows: rows, alignment: .center, spacing: 0, pinnedViews: [], content: {
                ForEach(faces) { face in
                    ZStack {
                        Square(color: pointColor.opacity(face.count / totalEntries )).border(.black.opacity(0.2))
                        Text("\(face.id)").opacity(0.7)
                    }
                }.background(Color(Constants.atmosphereColor).opacity(0.15))
            }).padding().frame(maxWidth: .infinity)

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
        .onChange(of: xShift, perform: { newX in
            motionController.updateShift(x: newX, y: 0, z: 0)
        })
        .onChange(of: yShift, perform: { newY in
            motionController.updateShift(x: 0, y: newY, z: 0)
        })
        .onChange(of: zShift, perform: { newZ in
            motionController.updateShift(x: 0, y: 0, z: newZ)
        })
        .onReceive(motionController.$positions, perform: { newPoints in
            if let lastPoint = newPoints.last {
                let latestMotionPoint = SCNVector3Make(lastPoint.x, lastPoint.y, lastPoint.z)
                let closestFace = sphericalScene.getClosestFaceToPoint(pt: latestMotionPoint)
                sphericalScene.addPoint(latestPoint: latestMotionPoint, pointColor: pointColor)
                sphericalScene.addAngle(latestPoint: latestMotionPoint, angles: [lastPoint.xAngle, lastPoint.yAngle, lastPoint.zAngle])
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
