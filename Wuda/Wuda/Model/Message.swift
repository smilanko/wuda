import Foundation
import simd

struct Message {
    
    let gravity, rotation: simd_quatd
    let orientation, ts: Double
    
    init(stream: [Double]) {
        self.gravity = simd_quatd(ix: stream[1], iy: stream[2], iz: stream[3], r: 0)
        self.rotation = simd_quatd(ix: stream[5], iy: stream[6], iz: stream[7], r: stream[4])
        self.orientation = stream[8]
        self.ts = stream[9]
    }
    
}
