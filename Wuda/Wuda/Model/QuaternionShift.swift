import Foundation
import simd

struct QuaternionShift: Identifiable, Equatable {
    var id = UUID()
    var q: simd_quatd
}
