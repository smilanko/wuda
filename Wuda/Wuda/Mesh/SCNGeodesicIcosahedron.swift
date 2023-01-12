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
    
    override init() {
        super.init()
        
        let vertices = pattern.generateVertices()
        let faces = pattern.generateFaces()
        
        let topY = vertices.map{$0.y}.max()!
        let color1 = NSColor(red: 255/255,green: 206/255,blue: 97/255, alpha: 1.0)
        let color2 = NSColor(red: 191/255, green: 52/255, blue: 117/255, alpha: 1.0)

        print(faces.count / 3)
        
        var geometries = [SCNGeometry]()
        var centers = [SCNVector3]()
        var crossProducts = [SCNVector3]()
        var tempPoss = [SCNVector3]()
        let totalIterations = faces.count / 3
        for i in 0..<totalIterations {
            let faceVertices = [vertices[Int(faces[i*3])], vertices[Int(faces[i*3+1])], vertices[Int(faces[i*3+2])]]
            
            // prepare centers
            let averageX = (faceVertices[0].x + faceVertices[1].x + faceVertices[2].x) / 3.0
            let averageY = (faceVertices[0].y + faceVertices[1].y + faceVertices[2].y) / 3.0
            let averageZ = (faceVertices[0].z + faceVertices[1].z + faceVertices[2].z) / 3.0
            let center = SCNVector3(averageX, averageY, averageZ)
            centers.append(center)
            
            // prepare geometries
            let faceGeometry = SCNGeometry(sources: [SCNGeometrySource(vertices: faceVertices)], elements: [SCNGeometryElement(indices: [0, 1, 2].map{Int32($0)}, primitiveType: .triangles)])
            let faceColorMaterial = SCNMaterial()
            faceColorMaterial.diffuse.contents = interpolateColor(color1: color1, color2: color2, proportion: (topY-averageY) / topY)
            faceGeometry.materials = [faceColorMaterial]
            geometries.append(faceGeometry)
            
            // prepare cross products
            let w = SCNVector3(x: faceVertices[0].x - center.x, y: faceVertices[0].y - center.y, z: faceVertices[0].z - center.z)
            let v = SCNVector3(x: faceVertices[2].x - center.x, y: faceVertices[2].y - center.y, z: faceVertices[2].z - center.z)
            crossProducts.append(normalize(vector: cross(vectorA: v, vectorB: w)))
            tempPoss.append(faceVertices[0])

        }

        let scaling = SCNMatrix4MakeScale(radius, radius, radius)
        self.transform = scaling
        self.geometry = nil
        self.name = "3D_Object"
        for idx in 0..<geometries.count {
            let geo = geometries[idx]
            let center = centers[idx]
            let crossProduct = crossProducts[idx]
            let temp = tempPoss[idx]
            
//            let pointGeometry = SCNSphere(radius: 0.02)
//            pointGeometry.firstMaterial?.diffuse.contents = NSColor.black
//            let pointNode = SCNNode(geometry: pointGeometry)
//            pointNode.position = crossProduct
            
            // Create the cylinder
            let pointGeometry = SCNCylinder(radius: 0.05, height: 0.01)
            pointGeometry.firstMaterial?.diffuse.contents = NSColor.black
            let pointNode = SCNNode(geometry: pointGeometry)
            pointNode.position = crossProduct
            let angle = atan2(crossProduct.y, crossProduct.x)
            pointNode.eulerAngles = SCNVector3(x: 0, y: 0, z: angle)

            // Create the text
//            let pointNode = createTriangleText("\(idx)")
//            pointNode.position = crossProduct
            
            // Calculate the rotation angle



            // Set the rotation axis
//            let rotationAxis = crossProduct

            // Set the rotation using the eulerAngles property
//            pointNode.eulerAngles = SCNVector3(x: rotationAxis.x * angle, y: rotationAxis.y * angle, z: rotationAxis.z * angle)

            
//            let pointGeometry = SCNCylinder(radius: 0.01, height: 0.2)
//            pointGeometry.firstMaterial?.diffuse.contents = NSColor.black
//            let pointNode = SCNNode(geometry: pointGeometry)
//            pointNode.position = crossProducts[idx]



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
    
}

