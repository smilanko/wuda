//
//  TextFile.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct MotionDataFile: FileDocument {
    // tell the system we support only plain text
    static var readableContentTypes = [UTType.plainText]
    var text = ""

    init(allHistory : [History], closestFace: [Int]) {
        // prepare the header
        text += "gravity_x,gravity_y,gravity_z,rotation_w,rotation_x,rotation_y,rotation_z,position_x,position_y,position_z,x_angle,y_angle,z_angle,wrist_orientation,closest_face,time\n"
        for idx in 0..<allHistory.count {
            let history = allHistory[idx]
            text += "\(history.gravity.vector.x),"
            text += "\(history.gravity.vector.y),"
            text += "\(history.gravity.vector.z),"
            text += "\(history.rotation.vector.w),"
            text += "\(history.rotation.vector.x),"
            text += "\(history.rotation.vector.y),"
            text += "\(history.rotation.vector.z),"
            text += "\(history.position.x),"
            text += "\(history.position.y),"
            text += "\(history.position.z),"
            text += "\(history.position.xAngle),"
            text += "\(history.position.yAngle),"
            text += "\(history.position.zAngle),"
            text += "\(history.orientation),"
            text += "\(history.orientation),"
            text += "\(closestFace[idx]),"
            text += "\(history.time)\n"
        }
    }

    init(configuration: ReadConfiguration) throws {
        // implement logic to load previous runs
    }

    // store a run
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
