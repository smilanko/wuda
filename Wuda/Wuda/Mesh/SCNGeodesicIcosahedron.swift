//
//  SCNGeodesicIcosahedron.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SceneKit

class SCNGeodesicIcosahedron : SCNNode {
    
    private let pattern = GeodesicIcosahedron16()
    private let color1 = NSColor(red: 255/255,green: 206/255,blue: 97/255, alpha: 1.0)
    private let color2 = NSColor(red: 191/255, green: 52/255, blue: 117/255, alpha: 1.0)
    
    override init() {
        super.init()
        
        let vertices = pattern.generateVertices()
        let faces = pattern.generateFaces()

        var geometries = [SCNGeometry]()
        var outlines = [SCNGeometry]()
        var centers = [SCNVector3]()
        
        let totalIterations = faces.count / 3
        for i in 0..<totalIterations {
            let faceVertices = [vertices[Int(faces[i*3])], vertices[Int(faces[i*3+1])], vertices[Int(faces[i*3+2])]]
            
            // prepare centers
            let center = SCNVector3(x: (faceVertices[0].x + faceVertices[1].x + faceVertices[2].x) / 3.0, y: (faceVertices[0].y + faceVertices[1].y + faceVertices[2].y) / 3.0, z: (faceVertices[0].z + faceVertices[1].z + faceVertices[2].z) / 3.0)
            centers.append(normalize(vector: center))
            
            // prepare geometries
            let faceGeometry = SCNGeometry(sources: [SCNGeometrySource(vertices: faceVertices)], elements: [SCNGeometryElement(indices: [0, 1, 2].map{Int32($0)}, primitiveType: .triangles)])
            faceGeometry.materials = [SCNMaterial()]
            faceGeometry.firstMaterial?.diffuse.contents = interpolateColor(color1: color1, color2: color2, proportion: (1-center.y))
            geometries.append(faceGeometry)
            
            // prepare outlines
            let outlineGeometry = SCNGeometry(sources: [SCNGeometrySource(vertices: faceVertices)], elements: [SCNGeometryElement(indices: [0, 1, 2].map{Int32($0)}, primitiveType: .line)])
            outlineGeometry.materials = [SCNMaterial()]
            outlineGeometry.firstMaterial?.diffuse.contents = NSColor.black
            outlines.append(outlineGeometry)
        }
        
        for idx in 0..<geometries.count {
            let centerPointNode = SCNNode(geometry: SCNSphere(radius: 0.005))
            centerPointNode.geometry?.firstMaterial?.diffuse.contents = NSColor.black
            centerPointNode.position = centers[idx]
            
            let mapIdNode = createTriangleText("\(idx)")
            mapIdNode.position = centers[idx]
            mapIdNode.look(at: SCNVector3Zero)
            mapIdNode.name = "\(idx)"
            
            self.addChildNode(SCNNode(geometry: geometries[idx]))
            self.addChildNode(SCNNode(geometry: outlines[idx]))
            self.addChildNode(centerPointNode)
            self.addChildNode(mapIdNode)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func interpolateColor(color1: NSColor, color2: NSColor, proportion: Double) -> NSColor {
        let red = color1.redComponent + (color2.redComponent - color1.redComponent) * CGFloat(proportion)
        let green = color1.greenComponent + (color2.greenComponent - color1.greenComponent) * CGFloat(proportion)
        let blue = color1.blueComponent + (color2.blueComponent - color1.blueComponent) * CGFloat(proportion)
        return NSColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    private func createTriangleText(_ label: String) -> SCNNode {
        let txt = SCNText(string: label, extrusionDepth: 1)
        txt.font = .systemFont(ofSize: 3)
        txt.firstMaterial?.diffuse.contents = NSColor.black
        let node = SCNNode(geometry: txt)
        node.scale = SCNVector3(0.01, 0.01, 0.001) // adjust the scale
        return node
    }
    
    func normalize(vector: SCNVector3) -> SCNVector3 {
        let length = sqrt(pow(vector.x, 2) + pow(vector.y, 2) + pow(vector.z, 2))
        return SCNVector3Make(vector.x / length, vector.y / length, vector.z / length)
    }
    
    func cross(vectorA: SCNVector3, vectorB: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(vectorA.y * vectorB.z - vectorA.z * vectorB.y, -1 * (vectorA.x * vectorB.z - vectorA.z * vectorB.x), vectorA.x * vectorB.y - vectorA.y * vectorB.x)
    }
    
    func dot(vectorA: SCNVector3, vectorB: SCNVector3) -> Double {
        return (vectorA.x * vectorB.x + vectorA.y * vectorB.y + vectorA.z * vectorB.z)
    }
    
    func distance(vectorA: SCNVector3, vectorB: SCNVector3) -> Double {
        return sqrt((vectorA.x - vectorB.x) * (vectorA.x - vectorB.x) + (vectorA.y - vectorB.y) * (vectorA.y - vectorB.y) + (vectorA.z - vectorB.z) * (vectorA.z - vectorB.z))
    }
    
}

