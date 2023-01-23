//
//  DirectionalLine.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import SwiftUI

struct DirectionalLine: Shape {
    
    @Binding var degrees: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.height / 2.0
        // re-orient
        path.move(to: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0))
        // new postion for x
        let cx = rect.width / 2.0
        let cy = rect.height / 2.0
        let x = cx + ( radius * cos(degrees * (.pi / -180.0)))
        let y = cy + ( radius * sin(degrees * (.pi / -180.0)))
        path.addLine(to: CGPoint(x: x, y: y))        
        return path
    }
    
}
