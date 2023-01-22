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
        path.move(to: CGPoint(x: rect.width / 2.0, y: rect.height))
        // new postion for x
        let cx = rect.width / 2.0
        let cy = rect.height
        let x = cx + ( radius * cos(degrees * (.pi / -180.0)))
        let y = cy + ( radius * sin(degrees * (.pi / -180.0)))
        path.addLine(to: CGPoint(x: x, y: y))
        
        let midDegrees = degrees / 2
        let midX = cx + ( radius * cos(midDegrees * (.pi / -180.0)))
        let midY = cy + ( radius * sin(midDegrees * (.pi / -180.0)))

        path.move(to: CGPoint(x: cx + radius, y: rect.height))
        path.addQuadCurve(to: CGPoint(x: x, y: y), control: CGPoint(x: midX, y: midY))
        
        return path
    }
    
}
