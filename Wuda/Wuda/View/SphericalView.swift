//
//  SphericalView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

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
        view.showsStatistics = true
        view.backgroundColor = .clear
        return view
    }
    
    func updateNSView(_ nsView: SCNView, context: Context) {
        // nothing for now
    }
    
}
