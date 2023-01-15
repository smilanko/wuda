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
    
    @ObservedObject private var experimentState = ExperimentState.shared
    @ObservedObject private var motionObserver = MotionPeripheral.shared
    
    let centerPointsOnGeodesicIcosahedron : [Int: SCNVector3]
    let scene: SCNScene

    func makeNSView(context: Context) -> SCNView {
        let view = SCNView()
        view.scene = scene
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.showsStatistics = true
        return view
    }
    
    func updateNSView(_ nsView: SCNView, context: Context) {
        if !experimentState.canUpdatePoints { return }
        if let sphere = nsView.scene?.rootNode.childNodes.first {
            if sphere.name != WudaConstants.rootNodeConstant {
                experimentState.addLogMessage(type: .error, msg: "Points must draw on the root!")
                return
            }
            let pointGeometry = SCNSphere(radius: 0.01)
            pointGeometry.firstMaterial?.diffuse.contents = NSColor(experimentState.pointColor)
            let pointNode = SCNNode(geometry: pointGeometry)
            pointNode.position = motionObserver.point
            sphere.addChildNode(pointNode)
        }
    }
    
}
