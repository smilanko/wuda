//
//  SceneView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI
import SceneKit

struct ExperimentationView: View {
    
    @ObservedObject private var motionObserver = MotionPeripheral.shared
    @State private var pointColor = Color(.sRGB, red: 122/255, green: 39/255, blue: 161/255)
    @State private var sphericalScene : SphericalScene = SphericalScene()
    @State private var canUpdatePoints : Bool = true
    @State private var freezeText : String = "Enabled"
    
    var body: some View {
        VStack {
            HStack {
                ColorPicker("Point Color", selection: $pointColor)
                Text("UI Updates: ")
                Text(freezeText).foregroundColor(canUpdatePoints ? .green : .red)
                Button {
                    canUpdatePoints.toggle()
                    freezeText = canUpdatePoints ? "Enabled" : "Disabled"
                } label: {
                    Text("Toggle")
                }
                Button {
                    sphericalScene.clearPoints()
                } label: {
                    Image(systemName: "trash.square.fill").foregroundColor(.red)
                }
            }
            .padding()
            HStack {
                SphericalView(canUpdatePoints: $canUpdatePoints, pointColor: $pointColor, scene: sphericalScene)
            }
        }
        .padding()
    }
    
}
