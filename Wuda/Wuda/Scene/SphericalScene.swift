import Foundation
import SceneKit
import SceneKit.SCNSceneRenderer
import SwiftUI
import simd

class SphericalScene: SCNScene {
    
    private let geodesicIcosahedron = SCNIcosahedron()
    private let radius = 1.0
    private var faceToCenterMapping: [Int: SCNVector3] = [:]
    private var addingPointToSphere: Bool = false
    private var addingAngleToSphere: Bool = false
    
    override init() {
        super.init()

        let sphere = SCNSphere(radius: radius)
        sphere.firstMaterial?.diffuse.contents = Constants.atmosphereColor.withAlphaComponent(0.2)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Zero
        sphereNode.name = Constants.rootNodeConstant
        
        let giRadius = radius - 0.06
        geodesicIcosahedron.transform = SCNMatrix4MakeScale(giRadius, giRadius, giRadius)
        geodesicIcosahedron.name = Constants.rootNodeForGeodasicMap
        
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
        telescopeGeometry.firstMaterial?.diffuse.contents = Constants.gradientStartColor
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
        
        LogController.shared.log(level: .info, msg: "Prepared the spherical scene")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addPoint(latestPoint: SCNVector3, pointColor: Color) {
        // throttle
        guard !addingPointToSphere, let sphere = self.rootNode.childNodes.first, sphere.name == Constants.rootNodeConstant else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            addingPointToSphere = true
            let pointGeometry = SCNSphere(radius: 0.01)
            pointGeometry.firstMaterial?.diffuse.contents = NSColor(pointColor)
            let pointNode = SCNNode(geometry: pointGeometry)
            pointNode.position = latestPoint
            sphere.addChildNode(pointNode)
            // prevent exaustion by removing 20% of max Items
            if sphere.childNodes.count >= Constants.maxPointsOnPlot {
                sphere.childNodes.prefix(Int(Double(Constants.maxPointsOnPlot) * 0.2)).forEach({ $0.removeFromParentNode() })
            }
            addingPointToSphere = false
        }
        
    }
    
    public func addAngle(latestPoint: SCNVector3, angles: [Double]) {
        // throttle
        guard !addingAngleToSphere, let anglesSphere = self.rootNode.childNodes.first(where: { $0.name == Constants.rootNodeForAngles }) else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if let telescope = anglesSphere.childNodes.first(where: { $0.name == Constants.rootNodeForTelescope }) {
                telescope.look(at: latestPoint, up: SCNVector3(0, 1, 0), localFront: SCNVector3(0, 1, 0))
            }
            anglesSphere.childNodes.filter({ $0.name != Constants.rootNodeForTelescope }).forEach({ $0.removeFromParentNode() })
            anglesSphere.addChildNode(createAxisAngle(angles[0], pos: SCNVector3(0.05,0,0)))
            anglesSphere.addChildNode(createAxisAngle(angles[1], pos: SCNVector3(0,0.05,0)))
            anglesSphere.addChildNode(createAxisAngle(angles[2], pos: SCNVector3(-0.05,0,-0.05)))
            addingAngleToSphere = false
        }
    }
    
    public func clear() {
        LogController.shared.log(level: .info, msg: "Clearing sphere")
        if let sphere = self.rootNode.childNodes.first {
            sphere.enumerateChildNodes { (node, stop) in
                node.removeFromParentNode()
            }
        }
    }
    
    public func updatePointColors(newColor: NSColor) {
        LogController.shared.log(level: .info, msg: "Updating sphere color")
        if let sphere = self.rootNode.childNodes.first {
            sphere.enumerateChildNodes { (node, stop) in
                node.geometry?.firstMaterial?.diffuse.contents = newColor
            }
        }
    }
    
    public func getClosestFaceToPoint(pt: SCNVector3) -> Int {
        var closestKey: Int = 0
        var closestDist: Float = Float.infinity
        faceToCenterMapping.forEach({ key, val in
            let dist = pt.distance(vector: val)
            if dist <= closestDist {
                closestDist = dist
                closestKey = key
            }
        })
        return closestKey
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

}

