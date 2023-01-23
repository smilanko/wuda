//
//  XaxisAngleView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import SwiftUI

enum AxisSelection {
    case xAxis
    case yAxis
    case zAxis
}

struct AngleView: View {
    
    @ObservedObject private var motionController = MotionController.shared
    @State public var centerColor = Color(Constants.gradientStartColor)
    @State public var angle : Double = 0.0
    
    public var axisSelection : AxisSelection
    
    var body: some View {

        VStack {
            Text("90\u{00B0}").frame(maxHeight: .infinity, alignment: .bottom)
            HStack {
                Text("180\u{00B0}").frame(maxWidth: .infinity, alignment: .trailing)
                ZStack {
                    // background circle
                    ZStack {
                        // outer circle
                        Circle().strokeBorder(.black,lineWidth: 1)
                        // gradient circle
                        Circle()
                            .fill(RadialGradient(gradient: Gradient(colors: [centerColor, getOuterColor()]), center: .center, startRadius: 50, endRadius: 100))
                            .padding(1)
                        // inner circle
                        Circle().strokeBorder(.black.opacity(0.3),lineWidth: 1).padding(40)
                        // overlay circle with atmosphere tint
                        Circle().fill(Color(Constants.atmosphereColor).opacity(0.2))
                    }
                    // background grid slices
                    ZStack {
                        Rectangle().fill(.black.opacity(0.2)).frame(height: 1).rotationEffect(Angle(degrees: 45))
                        Rectangle().fill(.black.opacity(0.2)).frame(height: 1).rotationEffect(Angle(degrees: 90))
                        Rectangle().fill(.black.opacity(0.2)).frame(height: 1).rotationEffect(Angle(degrees: 135))
                        Rectangle().fill(.black.opacity(0.2)).frame(height: 1)
                    }
                    // our line, a background circle to hold it, and value
                    ZStack {
                        DirectionalLine(degrees: $angle).stroke(.black, lineWidth: 2)
                        Circle().fill(.white).frame(minWidth: 50, maxWidth: 100, minHeight: 50, maxHeight: 100).padding(90)
                        Text("\(Int(angle))\u{00B0}")
                    }
                }
                Text("0\u{00B0}").frame(maxWidth: .infinity, alignment: .leading)
            }
            Text("270\u{00B0}").frame(maxHeight: .infinity, alignment: .top)
        }
        .padding()
        .onReceive(motionController.$positions, perform: { newPoints in
            if let lastPoint = newPoints.last {
                switch axisSelection {
                case .xAxis:
                    angle = lastPoint.xAngle
                case .yAxis:
                    angle = lastPoint.yAngle
                case .zAxis:
                    angle = lastPoint.zAngle
                }
            }
        })
    }
    
    private func getOuterColor() -> Color {
        switch axisSelection {
        case .xAxis:
            return .red
        case .yAxis:
            return .green
        case .zAxis:
            return .blue
        }
    }
    
}
