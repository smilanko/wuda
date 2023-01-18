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
    
    @ObservedObject private var logController = LogController.shared
    
    private var totalFaces : Int = 0
    private var faceToCenterMapping : [Int: SCNVector3] = [:]
    private let radius = 1.0
    
    init(isoPattern: IcosahedronPattern) {
        super.init()
        
        let sphere = SCNSphere(radius: radius)
        sphere.firstMaterial?.diffuse.contents = Constants.atmosphereColor.withAlphaComponent(0.15)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Zero
        sphereNode.name = Constants.rootNodeConstant
        
        let giRadius = radius - 0.06
        let geodesicIcosahedron = SCNIcosahedron(isoPattern: isoPattern)
        geodesicIcosahedron.transform = SCNMatrix4MakeScale(giRadius, giRadius, giRadius)
        geodesicIcosahedron.name = Constants.rootNodeForGeodasicMap
        totalFaces = geodesicIcosahedron.getFacesCount()
        
        let geoChildren = geodesicIcosahedron.childNodes
        for mapEntry in stride(from: 0, to:geoChildren.count, by: 3) {
            let nodeOfInterest = geoChildren[mapEntry + 2]
            if let nodeName = nodeOfInterest.name, let faceId = Int(nodeName) {
                faceToCenterMapping[faceId] = nodeOfInterest.position
            }
        }
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 2)
        
        self.rootNode.addChildNode(sphereNode)
        self.rootNode.addChildNode(geodesicIcosahedron)
        self.rootNode.addChildNode(cameraNode)
    }
    
    public func addPoint(latestPoint: SCNVector3, pointColor: Color) {
        if let sphere = self.rootNode.childNodes.first {
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
    
    public func clearPoints() {
        logController.addLogMessage(type: .info, msg: "Clearing sphere")
        if let sphere = self.rootNode.childNodes.first {
            sphere.enumerateChildNodes { (node, stop) in
                node.removeFromParentNode()
            }
        }
    }
    
    public func updatePointColors(newColor: NSColor) {
        logController.addLogMessage(type: .info, msg: "Updating sphere color")
        if let sphere = self.rootNode.childNodes.first {
            sphere.enumerateChildNodes { (node, stop) in
                node.geometry?.firstMaterial?.diffuse.contents = newColor
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
    
    public func getTotalFaces() -> Int {
        return totalFaces
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

