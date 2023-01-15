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

