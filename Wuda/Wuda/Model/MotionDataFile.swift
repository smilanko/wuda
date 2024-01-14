import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct MotionDataFile: FileDocument {
    static var readableContentTypes = [UTType.plainText]
    private let allHistory: [History]
    private let closestFace: [Int]
    
    init(allHistory: [History], closestFace: [Int]) {
        self.allHistory = allHistory
        self.closestFace = closestFace
    }

    init(configuration: ReadConfiguration) throws {
        // TODO:: implement logic to load previous runs
        self.allHistory = []
        self.closestFace = []
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        var text = ""
        // prepare the header
        text += "gravity_x,gravity_y,gravity_z,rotation_w,rotation_x,rotation_y,rotation_z,position_x,position_y,position_z,x_angle,y_angle,z_angle,wrist_orientation,closest_face,time\n"
        for (idx, history) in allHistory.enumerated() {
            text += "\(history.message.gravity.vector.x),"
            text += "\(history.message.gravity.vector.y),"
            text += "\(history.message.gravity.vector.z),"
            text += "\(history.message.rotation.vector.w),"
            text += "\(history.message.rotation.vector.x),"
            text += "\(history.message.rotation.vector.y),"
            text += "\(history.message.rotation.vector.z),"
            text += "\(history.position.x),"
            text += "\(history.position.y),"
            text += "\(history.position.z),"
            text += "\(history.position.xAngle),"
            text += "\(history.position.yAngle),"
            text += "\(history.position.zAngle),"
            text += "\(history.message.orientation),"
            text += "\(closestFace[idx]),"
            text += "\(history.message.ts)\n"
        }
        return FileWrapper(regularFileWithContents: Data(text.utf8))
    }
}
