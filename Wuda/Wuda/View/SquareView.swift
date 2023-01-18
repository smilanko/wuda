//
//  SquareView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI

// Our square
struct Square: View {
    var color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .frame(width: Constants.squareSize + 10, height: Constants.squareSize, alignment: .center)
            .foregroundColor(color)
    }
}
