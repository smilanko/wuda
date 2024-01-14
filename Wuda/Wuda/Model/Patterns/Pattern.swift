import Foundation
import SceneKit

protocol Pattern {
    var verteces: [SCNVector3] { get }
    var faces: [Int] { get }
}
