//
//  SphericalScene.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SceneKit
import SceneKit.SCNSceneRenderer
import SwiftUI
import simd

struct SphericalView: NSViewRepresentable {
    
    @ObservedObject private var settings = ExperimentState.shared
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
        if !settings.canUpdatePoints { return }
        if let sphere = nsView.scene?.rootNode.childNodes.first {
            if sphere.name != WudaConstants.rootNodeConstant { fatalError("[ERROR] Points must draw on the root! ") }
            let pointGeometry = SCNSphere(radius: 0.01)
            pointGeometry.firstMaterial?.diffuse.contents = NSColor(settings.pointColor)
            let pointNode = SCNNode(geometry: pointGeometry)
            pointNode.position = motionObserver.point
            sphere.addChildNode(pointNode)
        }
    }
    
}

class SphericalScene : SCNScene {
    
    private let xAxisColor = NSColor.red
    private let yAxisColor = NSColor.green
    private let zAxisColor = NSColor.blue
    private let radius = 1.0
    
    override init() {
        super.init()
        
        let sphere = SCNSphere(radius: radius)
        sphere.firstMaterial?.diffuse.contents = NSColor.black.withAlphaComponent(0.2)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x: 0, y: 0, z: 0)
        sphereNode.name = WudaConstants.rootNodeConstant
        
        let giRadius = radius - 0.05
        let geodesicIcosahedron = SCNGeodesicIcosahedron()
        geodesicIcosahedron.transform = SCNMatrix4MakeScale(giRadius, giRadius, giRadius)
        geodesicIcosahedron.name = WudaConstants.rootNodeForGeodasicMap
        
        self.rootNode.addChildNode(sphereNode)
        self.rootNode.addChildNode(geodesicIcosahedron)
    }
    
    public func clearPoints() {
        if let sphere = self.rootNode.childNodes.first {
            sphere.enumerateChildNodes { (node, stop) in
                node.removeFromParentNode()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

