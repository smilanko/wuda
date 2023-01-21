//
//  QuaternionShift.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import simd

struct QuaternionShift : Identifiable, Equatable {
    var id = UUID()
    var q : simd_quatd
}
