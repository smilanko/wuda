//
//  LogView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI
import SceneKit

struct LogView: View {
    
    private let logController = LogController.shared
    
    var body: some View {
        VStack {
            Text("The log message list updates events and scrolls to the most recent automatically.").multilineTextAlignment(.center)
            ScrollViewReader { scrollView in
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(logController.logs, id: \.self) { logMsg in
                            Text(logMsg.id.isoDate + " " + logMsg.level.rawValue + " " + logMsg.msg).multilineTextAlignment(.leading).frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .onChange(of: logController.logs, perform: { events in
                        if events.isEmpty { return }
                        scrollView.scrollTo(logController.logs[logController.logs.endIndex - 1])
                    })
                }
            }
            Button {
                logController.clearLogs()
            } label: {
                Text("Clear Logs")
                Image(systemName: "trash.square.fill").foregroundColor(.red)
            }
        }
        .padding()
    }
}
