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
    
    @State private var pointColor: NSColor = .blue
    @State private var sphericalScene : SphericalScene = SphericalScene()
    @State private var canUpdatePoints : Bool = true
    @State private var freezeText : String = "Enabled"
    
    var body: some View {
        VStack {
            HStack {
                Picker("Point Color", selection: $pointColor) {
                    Text("Red").tag(NSColor.red)
                    Text("Orange").tag(NSColor.orange)
                    Text("Blue").tag(NSColor.blue)
                }
                Text("UI Updates: ")
                Text(freezeText).foregroundColor(canUpdatePoints ? .green : .red)
                Button {
                    canUpdatePoints.toggle()
                    freezeText = canUpdatePoints ? "Enabled" : "Disabled"
                } label: {
                    Text("Toggle")
                }
                Button {
                    sphericalScene.clearPoints()
                } label: {
                    Image(systemName: "trash.square.fill").foregroundColor(.red)
                }
            }.padding()
            SCNViewWrapper(canUpdatePoints: $canUpdatePoints, pointColor: $pointColor, scene: sphericalScene)
        }
        .padding()
    }
    
}

struct SCNViewWrapper: NSViewRepresentable {
    
    @ObservedObject private var motionObserver = MotionPeripheral.shared
    @Binding var canUpdatePoints : Bool
    @Binding var pointColor: NSColor
    let scene: SCNScene

    func makeNSView(context: Context) -> SCNView {
        let view = SCNView()
        view.scene = scene
        view.allowsCameraControl = true
        view.showsStatistics = true
        view.autoenablesDefaultLighting = true
        return view
    }
    
    func updateNSView(_ nsView: SCNView, context: Context) {
        if !canUpdatePoints { return }
        let pointGeometry = SCNSphere(radius: 0.01)
        pointGeometry.firstMaterial?.diffuse.contents = pointColor
        let pointNode = SCNNode(geometry: pointGeometry)
        pointNode.position = motionObserver.point
        let sphere = nsView.scene?.rootNode.childNodes.first
        sphere?.addChildNode(pointNode)
    }
    
}