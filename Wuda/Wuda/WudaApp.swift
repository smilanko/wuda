//
//  WudaApp.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import SwiftUI

@main
struct WudaApp: App {
    var body: some Scene {
        WindowGroup("Wuda") {
            ExperimentationView()
                .onAppear {
                    NSWindow.allowsAutomaticWindowTabbing = false
                }
        }
        
        Window("Logs", id: "logs") {
            LogView()
        }
        
        Window("Heatmap", id: "map") {
            MapView()
        }
        
        Window("X-Axis Angle", id: "xaxisAngle") {
            AngleView(axisSelection: .xAxis)
        }
        
        Window("Y-Axis Angle", id: "yaxisAngle") {
            AngleView(axisSelection: .yAxis)
        }
        
        Window("Z-Axis Angle", id: "zaxisAngle") {
            AngleView(axisSelection: .zAxis)
        }
        
        Window("Transformations", id: "shift") {
            QuaternionShiftView()
        }
        
    }
}
