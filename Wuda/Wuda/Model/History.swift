import Foundation
import simd

struct History {
    let gravity, rotation: simd_quatd
    let position: Position
    let orientation, time: Double
}
