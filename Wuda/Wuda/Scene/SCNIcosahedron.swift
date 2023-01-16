//
//  SCNGeodesicIcosahedron.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SceneKit

enum IcosahedronPattern {
    case geodasicPattern1
    case geodasicPattern2
    case geodasicPattern8
    case geodasicPattern16
}

class SCNIcosahedron : SCNNode {
    
    private let startColor = NSColor(red: 255/255,green: 206/255,blue: 97/255, alpha: 1.0)
    private let endColor = NSColor(red: 191/255, green: 52/255, blue: 117/255, alpha: 1.0)
    
    init(isoPattern: IcosahedronPattern) {
        super.init()
        
        let pattern : Pattern = getPatternFromType(isoPattern: isoPattern)
        let vertices = pattern.generateVertices()
        let faces = pattern.generateFaces()

        var faceGeometries = [SCNGeometry]()
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
            faceGeometry.firstMaterial?.diffuse.contents = interpolateColor(color1: startColor, color2: endColor, proportion: (1-center.y))
            faceGeometries.append(faceGeometry)
        }
        
        for idx in 0..<faceGeometries.count {
            let mapNode = createText("\(idx)")
            mapNode.position = centers[idx]
            mapNode.look(at: SCNVector3Zero)
            
            let centerPointNode = SCNNode(geometry: SCNSphere(radius: 0.005))
            centerPointNode.geometry?.firstMaterial?.diffuse.contents = NSColor.black
            centerPointNode.position = centers[idx]
            centerPointNode.name = "\(idx)"

            self.addChildNode(SCNNode(geometry: faceGeometries[idx]))
            self.addChildNode(mapNode)
            self.addChildNode(centerPointNode)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("[ERROR] init(coder:) has not been implemented")
    }
    
    private func getPatternFromType(isoPattern : IcosahedronPattern) -> Pattern {
        switch isoPattern {
        case .geodasicPattern1:
            return GeodesicIcosahedron1()
        case .geodasicPattern2:
            return GeodesicIcosahedron2()
        case .geodasicPattern8:
            return GeodesicIcosahedron8()
        case .geodasicPattern16:
            return GeodesicIcosahedron16()
        }
    }
    
    private func interpolateColor(color1: NSColor, color2: NSColor, proportion: Double) -> NSColor {
        let red = color1.redComponent + (color2.redComponent - color1.redComponent) * CGFloat(proportion)
        let green = color1.greenComponent + (color2.greenComponent - color1.greenComponent) * CGFloat(proportion)
        let blue = color1.blueComponent + (color2.blueComponent - color1.blueComponent) * CGFloat(proportion)
        return NSColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    private func createText(_ label: String) -> SCNNode {
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
    
}

