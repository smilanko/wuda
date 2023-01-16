//
//  SphericalView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SceneKit
import SwiftUI

struct SphericalView: NSViewRepresentable {
    
    @ObservedObject private var logController = LogController.shared
    @Binding var canUpdatePoints : Bool
    @Binding var pointColor : Color
    @Binding var latestPoint : SCNVector3
    
    var scene: SCNScene

    func makeNSView(context: Context) -> SCNView {
        let view = SCNView()
        view.scene = scene
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.showsStatistics = true
        view.backgroundColor = .clear
        return view
    }
    
    func updateNSView(_ nsView: SCNView, context: Context) {
        if !canUpdatePoints { return }
        if let sphere = nsView.scene?.rootNode.childNodes.first {
            if sphere.name != Constants.rootNodeConstant {
                logController.addLogMessage(type: .fatal, msg: "Points must draw on the root!")
            }
            let pointGeometry = SCNSphere(radius: 0.01)
            pointGeometry.firstMaterial?.diffuse.contents = NSColor(pointColor)
            let pointNode = SCNNode(geometry: pointGeometry)
            pointNode.position = latestPoint
            sphere.addChildNode(pointNode)
        }
    }
    
}
