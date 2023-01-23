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
    
    override init() {
        super.init()
        
        logController.addLogMessage(type: .info, msg: "Preparing the spherical scene")
        let sphere = SCNSphere(radius: radius)
        sphere.firstMaterial?.diffuse.contents = Constants.atmosphereColor.withAlphaComponent(0.2)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Zero
        sphereNode.name = Constants.rootNodeConstant
        
        let giRadius = radius - 0.06
        let geodesicIcosahedron = SCNIcosahedron()
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
        
        let anglesSphere = SCNSphere(radius: radius - 0.7)
        anglesSphere.firstMaterial?.diffuse.contents = Constants.atmosphereColor
        anglesSphere.firstMaterial?.isDoubleSided = true
        let anglesSphereNode = SCNNode(geometry: anglesSphere)
        anglesSphereNode.position = SCNVector3Zero
        anglesSphereNode.name = Constants.rootNodeForAngles
        
        let telescopeGeometry = SCNCylinder(radius: 0.005, height: 0.05)
        telescopeGeometry.firstMaterial?.diffuse.contents = NSColor.black
        let telescopeNode = SCNNode(geometry: telescopeGeometry)
        telescopeNode.name = Constants.rootNodeForTelescope
        telescopeNode.look(at: SCNVector3(1, 0, 0))
        anglesSphereNode.addChildNode(telescopeNode)
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 2)
        
        self.rootNode.addChildNode(sphereNode)
        self.rootNode.addChildNode(geodesicIcosahedron)
        self.rootNode.addChildNode(anglesSphereNode)
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
    
    public func addAngle(latestPoint: SCNVector3, angles: [Double]) {
        if let anglesSphere = self.rootNode.childNodes.first(where: { $0.name == Constants.rootNodeForAngles }) {
            // update our telescope
            if let telescope = anglesSphere.childNodes.first(where: { $0.name == Constants.rootNodeForTelescope }) {
                telescope.look(at: latestPoint, up: SCNVector3(0, 1, 0), localFront: SCNVector3(0, 1, 0))
            }
            // redraw our axis
            anglesSphere.childNodes.filter({ $0.name != Constants.rootNodeForTelescope }).forEach({ $0.removeFromParentNode() })
            anglesSphere.addChildNode(createAxisAngle(angles[0], pos: SCNVector3(0.05,0,0)))
            anglesSphere.addChildNode(createAxisAngle(angles[1], pos: SCNVector3(0,0.05,0)))
            anglesSphere.addChildNode(createAxisAngle(angles[2], pos: SCNVector3(-0.05,0,-0.05)))
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
    
    private func createAxisAngle(_ degrees: Double, pos: SCNVector3) -> SCNNode {
        let txt = SCNText(string: String(format: "%.2f", degrees), extrusionDepth: 1)
        txt.font = .systemFont(ofSize: 3)
        txt.firstMaterial?.diffuse.contents = NSColor.black
        let node = SCNNode(geometry: txt)
        node.scale = SCNVector3(0.005, 0.005, 0.001) // adjust the scale
        node.position = pos
        return node
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

