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
    
    @ObservedObject private var settings = ExperimentSettings.shared
    @State private var sphericalScene : SphericalScene = SphericalScene()
    @State private var freezeText : String = "Enabled"
    @State private var anglePlaneIdx : Double = 0.0
    
    var body: some View {
        // configuration menu
        HStack {
            ColorPicker("Sphere Point Color", selection: $settings.pointColor)
                .padding()
                .border(.black)
                .background(.white)
                .fixedSize(horizontal: true, vertical: true)
            
            Spacer()
            
            HStack {
                
                Button {
                    sphericalScene.clearPoints()
                    settings.clearScatterPlot.toggle()
                } label: {
                    Text("Clear Charts")
                    Image(systemName: "trash.square.fill").foregroundColor(.red)
                }
                
                Text("UI: ")
                Text(freezeText).foregroundColor(settings.canUpdatePoints ? .green : .red)
                Button {
                    settings.canUpdatePoints.toggle()
                    freezeText = settings.canUpdatePoints ? "Enabled" : "Disabled"
                } label: {
                    Text("Toggle")
                }
            }
            .padding()
            .border(.black)
            .background(.white)
            .fixedSize(horizontal: true, vertical: true)
        
            Spacer()
            
            HStack {
                Picker("Angle between the vector ", selection: $settings.pointSelection) {
                    ForEach(settings.pointOptionStrings, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.menu)
                
                Picker("and ", selection: $settings.axisSelection) {
                    ForEach(settings.axisOptions, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                
                Picker("using ", selection: $settings.trigSelection) {
                    ForEach(settings.trigOptions, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                
            }
            .padding()
            .border(.black)
            .background(.white)
            .fixedSize(horizontal: true, vertical: true)
        }
        .padding(5)
        
        HStack {
            SphericalView(scene: sphericalScene).border(.black).background(.white)
            ScatterPlot(anglePlaneIdx: $anglePlaneIdx).border(.black).background(.white)
        }.padding(5)
    }
    
}
