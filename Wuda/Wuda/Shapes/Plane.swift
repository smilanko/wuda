//
//  Plane.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI

struct Plane: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.move(to: CGPoint(x: rect.width / 2.0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width / 2.0, y: 0))
        return path
    }
}
