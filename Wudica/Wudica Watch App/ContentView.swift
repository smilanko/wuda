//
//  ContentView.swift
//  Wudica Watch App
//
//  Created by Slobodan Milanko
//

import SwiftUI
import CoreBluetooth
import CoreMotion

struct ContentView: View {
    @ObservedObject private var motionObserver = MotionObserver()
    
    var body: some View {
        
        VStack {
            HStack {
                Button("Start") {
                    motionObserver.start()
                }.disabled(motionObserver.isRunning)
                Button("Stop") {
                    motionObserver.stop()
                }.disabled(!motionObserver.isRunning)
            }
            HStack {
                Text("H").foregroundColor(.pink)
                Text("g").foregroundColor(.blue)
            }
            Text("(\(motionObserver.w, specifier: "%.2f"),\(motionObserver.x, specifier: "%.2f"),\(motionObserver.y, specifier: "%.2f"),\(motionObserver.z, specifier: "%.2f"))").foregroundColor(.pink)
            Text("(\(motionObserver.gx, specifier: "%.2f"),\(motionObserver.gy, specifier: "%.2f"),\(motionObserver.gz, specifier: "%.2f"))").foregroundColor(.blue)
        }.padding()
    }

}
