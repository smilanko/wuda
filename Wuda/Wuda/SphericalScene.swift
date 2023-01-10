//
//  SphericalScene.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SceneKit
import simd

class SphericalScene : SCNScene {
    
    override init() {
        super.init()
        
        // Create sphere
        let radius: CGFloat = 1.0
        let sphereGeometry = SCNSphere(radius: radius)
        sphereGeometry.firstMaterial?.diffuse.contents = NSColor.clear
        let sphereNode = SCNNode(geometry: sphereGeometry)
        self.rootNode.addChildNode(sphereNode)
        
        let sphereForPlotsGeometry = SCNSphere(radius: radius * 0.99)
        sphereForPlotsGeometry.firstMaterial?.diffuse.contents = NSColor.white.withAlphaComponent(0.8)
        let sphereForPlotsNote = SCNNode(geometry: sphereForPlotsGeometry)
        self.rootNode.addChildNode(sphereForPlotsNote)
        
        for i in stride(from: -90.0, through: 90.0, by: 10.0) {
            let latitudeLineGeometry = SCNTube(innerRadius: radius * 0.98, outerRadius: radius * 0.99, height: 0.001)
            latitudeLineGeometry.firstMaterial?.diffuse.contents = NSColor.gray.withAlphaComponent(0.5)
            let latitudeLineNode = SCNNode(geometry: latitudeLineGeometry)
            latitudeLineNode.simdWorldOrientation = simd_quatf.init(angle: Float(Measurement(value: i, unit: UnitAngle.degrees).converted(to: .radians).value), axis: simd_float3(1, 0, 0))
            self.rootNode.addChildNode(latitudeLineNode)
        }
        
        for i in stride(from: 0.0, through: 360.0, by: 20.0) {
            let longitudeLineGeometry = SCNTube(innerRadius: radius * 0.98, outerRadius: radius * 0.99, height: 0.001)
            longitudeLineGeometry.firstMaterial?.diffuse.contents = NSColor.gray.withAlphaComponent(0.5)
            let longitudeLineNode = SCNNode(geometry: longitudeLineGeometry)
            longitudeLineNode.simdWorldOrientation = simd_quatf.init(angle: Float(Measurement(value: i, unit: UnitAngle.degrees).converted(to: .radians).value), axis: simd_float3(0, 0, 1))
            self.rootNode.addChildNode(longitudeLineNode)
        }
        
        // X-axis
        let xGeometry = SCNCylinder(radius: 0.01, height: radius * 2)
        xGeometry.firstMaterial?.diffuse.contents = NSColor.orange
        let xNode = SCNNode(geometry: xGeometry)
        xNode.simdWorldOrientation = simd_quatf.init(angle: .pi/2, axis: simd_float3(0, 0, 1))
        
        // Y-axis
        let yGeometry = SCNCylinder(radius: 0.01, height: radius * 2)
        yGeometry.firstMaterial?.diffuse.contents = NSColor.black
        let yNode = SCNNode(geometry: yGeometry)
        yNode.position = SCNVector3(0, 0, 0)
        
        // Z-axis
        let zGeometry = SCNCylinder(radius: 0.01, height: radius * 2)
        zGeometry.firstMaterial?.diffuse.contents = NSColor.red
        let zNode = SCNNode(geometry: zGeometry)
        zNode.simdWorldOrientation = simd_quatf(angle: -.pi/2, axis: simd_float3(1, 0, 0))
    
        // Add the axis nodes as children of the sphere node
        self.rootNode.addChildNode(xNode)
        self.rootNode.addChildNode(yNode)
        self.rootNode.addChildNode(zNode)
        
        // Create the x axis label
        let xAxisLabel = SCNText(string: "X+", extrusionDepth: 1)
        xAxisLabel.font = .systemFont(ofSize: 2) // adjust the font size
        xAxisLabel.firstMaterial?.diffuse.contents = NSColor.orange
        let xAxisLabelNode = SCNNode(geometry: xAxisLabel)
        xAxisLabelNode.scale = SCNVector3(0.05, 0.05, 0.02) // adjust the scale
        xAxisLabelNode.position = SCNVector3(x: 1, y: 0, z: 0)
        
        // Create the y axis label
        let yAxisLabel = SCNText(string: "Y+", extrusionDepth: 1)
        yAxisLabel.font = .systemFont(ofSize: 2) // adjust the font size
        yAxisLabel.firstMaterial?.diffuse.contents = NSColor.black
        let yAxisLabelNode = SCNNode(geometry: yAxisLabel)
        yAxisLabelNode.scale = SCNVector3(0.05, 0.05, 0.02) // adjust the scale
        yAxisLabelNode.position = SCNVector3(x: 0, y: 1, z: 0)
        
        // Create the y axis label
        let zAxisLabel = SCNText(string: "Z+", extrusionDepth: 1)
        zAxisLabel.font = .systemFont(ofSize: 2) // adjust the font size
        zAxisLabel.firstMaterial?.diffuse.contents = NSColor.red
        let zAxisLabelNode = SCNNode(geometry: zAxisLabel)
        zAxisLabelNode.scale = SCNVector3(0.05, 0.05, 0.02) // adjust the scale
        zAxisLabelNode.position = SCNVector3(x: 0, y: 0, z: 1)

        self.rootNode.addChildNode(xAxisLabelNode)
        self.rootNode.addChildNode(yAxisLabelNode)
        self.rootNode.addChildNode(zAxisLabelNode)
        
        let leftDegrees = Measurement(value: -60, unit: UnitAngle.degrees).converted(to: .radians).value
        let rightDegrees = Measurement(value: -20, unit: UnitAngle.degrees).converted(to: .radians).value
        let rotation = simd_quatd(ix: 0, iy: sin(leftDegrees), iz: 0, r: cos(leftDegrees)) * simd_quatd(ix: 0, iy: 0, iz: sin(rightDegrees), r: cos(rightDegrees))
        self.rootNode.rotation = SCNVector4(x: CGFloat(rotation.vector.x), y: CGFloat(rotation.vector.y), z: CGFloat(rotation.vector.z), w: CGFloat(rotation.vector.w))
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
