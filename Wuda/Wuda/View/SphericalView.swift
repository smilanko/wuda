import Foundation
import SceneKit
import SwiftUI

struct SphericalView: NSViewRepresentable {
    
    var scene: SCNScene

    func makeNSView(context: Context) -> SCNView {
        let view = SCNView()
        view.scene = scene
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.showsStatistics = false
        view.backgroundColor = .clear
        // show the world axis
        view.debugOptions = [SCNDebugOptions(rawValue: 2048)]
        return view
    }
    
    func updateNSView(_ nsView: SCNView, context: Context) {
        // nothing for now
    }
    
}
