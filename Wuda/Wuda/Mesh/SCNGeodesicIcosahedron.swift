//
//  SCNGeodesicIcosahedron.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SceneKit

class SCNGeodesicIcosahedron : SCNNode {
    
    private let pattern = MeshPattern()
    
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
        let totalIterations = faces.count / 3
        for i in 0..<totalIterations {
            let faceVertices = [vertices[Int(faces[i*3])], vertices[Int(faces[i*3+1])], vertices[Int(faces[i*3+2])]]
            let faceGeometry = SCNGeometry(sources: [SCNGeometrySource(vertices: faceVertices)], elements: [SCNGeometryElement(indices: [0, 1, 2].map{Int32($0)}, primitiveType: .triangles)])
            
            let averageX = (faceVertices[0].x + faceVertices[1].x + faceVertices[2].x) / 3.0
            let averageY = (faceVertices[0].y + faceVertices[1].y + faceVertices[2].y) / 3.0
            let averageZ = (faceVertices[0].z + faceVertices[1].z + faceVertices[2].z) / 3.0
            let center = SCNVector3(averageX, averageY, averageZ)
        
            faceGeometry.materials = [SCNMaterial()]
            let proportion = (topY-averageY) / topY
            faceGeometry.materials[0].diffuse.contents = interpolateColor(color1: color1, color2: color2, proportion: proportion)
            
            centers.append(center)
            geometries.append(faceGeometry)
        }

        let scaling = SCNMatrix4MakeScale(0.98, 0.98, 0.98)
        self.transform = scaling
        self.geometry = nil
        self.name = "3D_Object"
        for idx in 0..<geometries.count {
            let geo = geometries[idx]
            let center = centers[idx]
            
            let pointGeometry = SCNSphere(radius: 0.005)
            pointGeometry.firstMaterial?.diffuse.contents = NSColor.gray
            let pointNode = SCNNode(geometry: pointGeometry)
            pointNode.position = center
            self.addChildNode(SCNNode(geometry: geo))
            self.addChildNode(pointNode)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func interpolateColor(color1: NSColor, color2: NSColor, proportion: Double) -> NSColor {
        let red = color1.redComponent + (color2.redComponent - color1.redComponent) * CGFloat(proportion)
        let green = color1.greenComponent + (color2.greenComponent - color1.greenComponent) * CGFloat(proportion)
        let blue = color1.blueComponent + (color2.blueComponent - color1.blueComponent) * CGFloat(proportion)
        return NSColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
