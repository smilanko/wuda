//
//  CoolioView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI
import SceneKit

struct LogView <Content: View>: View {
    
    @State private var isExpanded = false
    @ViewBuilder let expandableView : Content
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeIn(duration: 0.2)) {
                    self.isExpanded.toggle()
                }
            }){
                Text("Logs")
                Image(systemName: "chevron.down.circle.fill")
            }
            
            if self.isExpanded {
                self.expandableView.frame(maxHeight: 100)
            }
        }
    }
}
