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
        
        Window("Quaternion Shifts", id: "shift") {
            QuaternionShiftView()
        }
    }
}
