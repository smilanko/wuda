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
    private let radius = 0.99
    private let color1 = NSColor(red: 255/255,green: 206/255,blue: 97/255, alpha: 1.0)
    private let color2 = NSColor(red: 191/255, green: 52/255, blue: 117/255, alpha: 1.0)
    
    override init() {
        super.init()
        
        let vertices = pattern.generateVertices()
        let faces = pattern.generateFaces()

        var geometries = [SCNGeometry]()
        var centers = [SCNVector3]()
        var crossProducts = [SCNVector3]()
        
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
            
            // prepare cross products
            let v1 = SCNVector3(x: faceVertices[1].x - faceVertices[0].x, y: faceVertices[1].y - faceVertices[0].y, z: faceVertices[1].z - faceVertices[0].z)
            let v2 = SCNVector3(x: faceVertices[2].x - faceVertices[0].x, y: faceVertices[2].y - faceVertices[0].y, z: faceVertices[2].z - faceVertices[0].z)
            let normal = normalize(vector: cross(vectorA: v1, vectorB: v2))
            crossProducts.append(normal)
        }
        
        print(vertices.map{$0.y}.min()!)

        let scaling = SCNMatrix4MakeScale(radius, radius, radius)
        self.transform = scaling
        self.geometry = nil
        self.name = "3D_Object"
        for idx in 0..<geometries.count {
            let geo = geometries[idx]
            var center = centers[idx]
            let crossProduct = crossProducts[idx]

//            let pointGeometry = SCNCylinder(radius: 0.02, height: 0.07)
//            pointGeometry.firstMaterial?.diffuse.contents = NSColor.black
//            let pointNode = SCNNode(geometry: pointGeometry)
//            pointNode.position = center

            let pointGeometry = SCNSphere(radius: 0.02)
            pointGeometry.firstMaterial?.diffuse.contents = NSColor.black
            let pointNode = SCNNode(geometry: pointGeometry)
            pointNode.position = center

            self.addChildNode(SCNNode(geometry: geo))
            self.addChildNode(pointNode)
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
        txt.font = .systemFont(ofSize: 2)
        txt.flatness = 0
        txt.firstMaterial?.diffuse.contents = NSColor.black
        let node = SCNNode(geometry: txt)
        node.scale = SCNVector3(0.01, 0.01, 0.01) // adjust the scale
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
    
}

