//
//  XaxisAngleView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import SwiftUI

struct XaxisAngleView: View {
    
    @ObservedObject private var motionController = MotionController.shared
    
    @State public var angle : Double = 130.0
    
    var body: some View {
        
        ZStack {
            Grid().stroke(.cyan.opacity(0.2), lineWidth: 1)
            Plane().stroke(.red, lineWidth: 2)
            DirectionalLine(degrees: $angle).stroke(.green, lineWidth: 1)
            Text("\(Int(angle))")
        }
        .padding()
        .onReceive(motionController.$positions, perform: { newPoints in
            if let lastPoint = newPoints.last {
                angle = lastPoint.zAngle
            }
        })
        
    }
    
}
