//
//  Grid.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation

import Foundation
import SwiftUI

struct Grid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // add the horizontal lines
        for idx in stride(from: 0.0, to: 6.0, by: 1.0) {
            let offsetY = idx * ( rect.height / 6.0 )
            path.move(to: CGPoint(x: 0, y: offsetY))
            path.addLine(to: CGPoint(x: rect.width, y: offsetY))
        }
        // add the vertical lines
        for idx in stride(from: 0.0, to: 10.0, by: 1.0) {
            let offsetX = idx * (rect.width / 10.0)
            path.move(to: CGPoint(x: offsetX, y: 0))
            path.addLine(to: CGPoint(x: offsetX, y: rect.height))
        }
        return path
    }
}
