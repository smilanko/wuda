//
//  PositionMap.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI
import SceneKit

struct PositionMap <Content: View>: View {
    
    @State private var isExpanded = false
    @ViewBuilder let expandableView : Content
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeIn(duration: 0.2)) {
                    self.isExpanded.toggle()
                }
            }){
                Text("Position Map")
                Image(systemName: "map.circle.fill")
            }
            
            if self.isExpanded {
                self.expandableView.frame(maxHeight: 100)
            }
        }
    }
}
