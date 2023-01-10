//
//  SphericalScene.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SceneKit
import SwiftUI
import simd

struct SphericalView: NSViewRepresentable {
    
    @ObservedObject private var motionObserver = MotionPeripheral.shared
    @Binding var canUpdatePoints : Bool
    @Binding var pointColor: Color
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
        pointGeometry.firstMaterial?.diffuse.contents = NSColor(pointColor)
        let pointNode = SCNNode(geometry: pointGeometry)
        pointNode.position = motionObserver.point
        let sphere = nsView.scene?.rootNode.childNodes.first
        sphere?.addChildNode(pointNode)
    }
    
}

class SphericalScene : SCNScene {
    
    private let xAxisColor = NSColor.red
    private let yAxisColor = NSColor.green
    private let zAxisColor = NSColor.blue
    
    override init() {
        super.init()
        
        // Create a base sphere
        let radius: CGFloat = 1.0
        let sphereGeometry = SCNSphere(radius: radius)
        sphereGeometry.firstMaterial?.diffuse.contents = NSColor.clear
        let sphereNode = SCNNode(geometry: sphereGeometry)
        self.rootNode.addChildNode(sphereNode)
        
        // Add an inner sphere so that you do not see "through" the base sphere
        let sphereForPlotsGeometry = SCNSphere(radius: radius * 0.99)
        sphereForPlotsGeometry.firstMaterial?.diffuse.contents = NSColor.white.withAlphaComponent(0.8)
        let sphereForPlotsNote = SCNNode(geometry: sphereForPlotsGeometry)
        self.rootNode.addChildNode(sphereForPlotsNote)
        
        // Create latitude lines
        for i in stride(from: -90.0, through: 90.0, by: 10.0) {
            let latitudeLineGeometry = SCNTube(innerRadius: radius * 0.98, outerRadius: radius * 0.99, height: 0.001)
            latitudeLineGeometry.firstMaterial?.diffuse.contents = NSColor.gray.withAlphaComponent(0.5)
            let latitudeLineNode = SCNNode(geometry: latitudeLineGeometry)
            latitudeLineNode.simdWorldOrientation = simd_quatf.init(angle: Float(Measurement(value: i, unit: UnitAngle.degrees).converted(to: .radians).value), axis: simd_float3(1, 0, 0))
            self.rootNode.addChildNode(latitudeLineNode)
        }
        
        // Create longitude lines
        for i in stride(from: 0.0, through: 360.0, by: 20.0) {
            let longitudeLineGeometry = SCNTube(innerRadius: radius * 0.98, outerRadius: radius * 0.99, height: 0.001)
            longitudeLineGeometry.firstMaterial?.diffuse.contents = NSColor.gray.withAlphaComponent(0.5)
            let longitudeLineNode = SCNNode(geometry: longitudeLineGeometry)
            longitudeLineNode.simdWorldOrientation = simd_quatf.init(angle: Float(Measurement(value: i, unit: UnitAngle.degrees).converted(to: .radians).value), axis: simd_float3(0, 0, 1))
            self.rootNode.addChildNode(longitudeLineNode)
        }
        
    
        // Add the axis lines and text as children of the sphere node
        self.rootNode.addChildNode(createAxis(radius: radius, orientation: simd_quatf.init(angle: .pi/2, axis: simd_float3(0, 0, 1)), color: xAxisColor))
        self.rootNode.addChildNode(createAxis(radius: radius, orientation: nil, color: yAxisColor))
        self.rootNode.addChildNode(createAxis(radius: radius, orientation: simd_quatf(angle: -.pi/2, axis: simd_float3(1, 0, 0)), color: zAxisColor))
        self.rootNode.addChildNode(createAxisLabel(label: "X+", position: SCNVector3(x: 1, y: 0, z: 0), color: xAxisColor))
        self.rootNode.addChildNode(createAxisLabel(label: "Y+", position: SCNVector3(x: 0, y: 1, z: 0), color: yAxisColor))
        self.rootNode.addChildNode(createAxisLabel(label: "Z+", position: SCNVector3(x: 0, y: 0, z: 1), color: zAxisColor))
        
        // Re-orient the sphere to make it more natural to view
        let leftDegrees = Measurement(value: -60, unit: UnitAngle.degrees).converted(to: .radians).value
        let rightDegrees = Measurement(value: -20, unit: UnitAngle.degrees).converted(to: .radians).value
        let rotation = simd_quatd(ix: 0, iy: sin(leftDegrees), iz: 0, r: cos(leftDegrees)) * simd_quatd(ix: 0, iy: 0, iz: sin(rightDegrees), r: cos(rightDegrees))
        self.rootNode.rotation = SCNVector4(x: CGFloat(rotation.vector.x), y: CGFloat(rotation.vector.y), z: CGFloat(rotation.vector.z), w: CGFloat(rotation.vector.w))
    }
    
    private func createAxisLabel(label: String, position: SCNVector3, color: NSColor) -> SCNNode {
        let axisLabel = SCNText(string: label, extrusionDepth: 1)
        axisLabel.font = .systemFont(ofSize: 2) // adjust the font size
        axisLabel.firstMaterial?.diffuse.contents = color
        let axisLabelNode = SCNNode(geometry: axisLabel)
        axisLabelNode.scale = SCNVector3(0.05, 0.05, 0.02) // adjust the scale
        axisLabelNode.position = position
        return axisLabelNode
    }
    
    private func createAxis(radius: Double, orientation: simd_quatf?, color: NSColor) -> SCNNode {
        let geometry = SCNCylinder(radius: 0.01, height: radius * 2)
        geometry.firstMaterial?.diffuse.contents = color
        let node = SCNNode(geometry: geometry)
        if let orientation = orientation {
            node.simdWorldOrientation = orientation
        }
        return node
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
