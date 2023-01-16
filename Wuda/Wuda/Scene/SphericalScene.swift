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
    
    private let atmosphereColor : NSColor = NSColor(red: 192/255, green: 210/255, blue: 218/255, alpha: 1)
    private var faceToCenterMapping : [Int: SCNVector3] = [:]
    private let radius = 1.0
    
    override init() {
        super.init()
        
        let sphere = SCNSphere(radius: radius)
        sphere.firstMaterial?.diffuse.contents = atmosphereColor.withAlphaComponent(0.2)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x: 0, y: 0, z: 0)
        sphereNode.name = Constants.rootNodeConstant
        
        let giRadius = radius - 0.06
        let geodesicIcosahedron = SCNIcosahedron(isoPattern: .geodasicPattern16)
        geodesicIcosahedron.transform = SCNMatrix4MakeScale(giRadius, giRadius, giRadius)
        geodesicIcosahedron.name = Constants.rootNodeForGeodasicMap
        
        let geoChildren = geodesicIcosahedron.childNodes
        for mapEntry in stride(from: 0, to:geoChildren.count, by: 3) {
            let nodeOfInterest = geoChildren[mapEntry + 2]
            if let nodeName = nodeOfInterest.name, let faceId = Int(nodeName) {
                faceToCenterMapping[faceId] = nodeOfInterest.position
            }
        }
        
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
    
    public func getClosestFaceToPoint(pt: SCNVector3) -> Int {
        var closestKey : Int = 0
        var closestDist : Float = Float.infinity
        faceToCenterMapping.forEach({ key, val in
            let dist = pt.distance(to: val)
            if dist <= closestDist {
                closestDist = dist
                closestKey = key
            }
        })
        return closestKey
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

