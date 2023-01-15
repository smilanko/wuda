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
        WindowGroup("Experimentation") {
            ExperimentationView()
                .onAppear {
                    NSWindow.allowsAutomaticWindowTabbing = false
                }
        }.commands {
            CommandGroup(replacing: .newItem) { }
        }
    }
}
