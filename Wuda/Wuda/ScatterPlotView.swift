//
//  ScatterPlotView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI
import Charts

struct Angle: Identifiable {
    var id: UUID
    let x: Double
    let y: Double
}

struct ScatterPlot: View {

    @ObservedObject private var settings = ExperimentSettings.shared
    @ObservedObject private var motionObserver = MotionPeripheral.shared
    @State private var planeAngles : [Angle] = []
    @Binding var anglePlaneIdx : Double
    
    var body: some View {
        VStack {
            Chart(planeAngles) {
                PointMark(
                    x: .value("Sample", $0.x),
                    y: .value("Theta", $0.y)
                )
            }
            .chartYAxisLabel("Theta")
            .chartXAxisLabel("Sample")
            .chartYScale(domain: settings.trigSelection == WudaConstants.cosFunction ? [0, 180] : [-90, 90])
        }.onReceive(motionObserver.$planeAngle, perform: { planeAngle in
            if !settings.canUpdatePoints { return }
            let val = settings.axisSelection == WudaConstants.xAxis ? planeAngle.x : settings.axisSelection == WudaConstants.yAxis ? planeAngle.y : planeAngle.z
            planeAngles.append(Angle(id: UUID(), x: anglePlaneIdx, y: val))
            anglePlaneIdx += 1
        }).onReceive(settings.$pointSelection, perform: { _ in
            clearChart()
        }).onReceive(settings.$axisSelection, perform: { _ in
            clearChart()
        }).onReceive(settings.$trigSelection, perform: { _ in
            clearChart()
        }).onReceive(settings.$clearScatterPlot, perform: { _ in
            clearChart()
        })
        .padding()
    }
    
    private func clearChart() {
        planeAngles.removeAll()
        anglePlaneIdx = 0
    }
}
