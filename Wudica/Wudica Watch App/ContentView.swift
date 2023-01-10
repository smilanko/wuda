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
            Text("w: \(motionObserver.w, specifier: "%.2f")")
            Text("x: \(motionObserver.x, specifier: "%.2f")")
            Text("y: \(motionObserver.y, specifier: "%.2f")")
            Text("z: \(motionObserver.z, specifier: "%.2f")")
        }
    }

}
