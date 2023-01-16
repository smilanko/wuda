//
//  MotionController.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import CoreBluetooth
import SwiftUI
import simd

class MotionController: NSObject, ObservableObject, CBPeripheralManagerDelegate {

    @ObservedObject private var logController = LogController.shared
    @Published private(set) var positions : [Position] = []
    
    private var wudaPeripheralService = CBUUID(string: "12345678-1234-1234-1234-123456789012")
    private var wudaPeripheralMotionCharacteristicUuid = CBUUID(string: "12345678-1234-1234-1234-123456789013")
    private var smartWatchGravityEntries : [simd_quatd] = []
    private var smartWatchRotationEntries : [simd_quatd] = []
    
    private var smartWatchPointVector : simd_quatd?
    private var peripheralManager: CBPeripheralManager!
    private var motionService: CBMutableService!
    private var motionDataCharacteristic: CBMutableCharacteristic!

    public static let shared = MotionController()
    
    private override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            // Create the motion service and characteristic.
            motionService = CBMutableService(type: wudaPeripheralService, primary: true)
            motionDataCharacteristic = CBMutableCharacteristic(type: wudaPeripheralMotionCharacteristicUuid, properties: [.writeWithoutResponse, .notify], value: nil, permissions: [.writeable, .readable])
            motionService.characteristics = [motionDataCharacteristic]
            // Add the service to the peripheral manager.
            peripheralManager.add(motionService)
            // Start advertising the service.
            peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [wudaPeripheralService]])
            logController.addLogMessage(type: .info, msg: "Advertising to wudica 🥰")
        case .poweredOff, .resetting, .unauthorized, .unsupported:
            // Stop advertising the service.
            peripheralManager.stopAdvertising()
            logController.addLogMessage(type: .info, msg: "Stopping service. Bye wudica 🛌")
        default:
            break
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        logController.addLogMessage(type: .info, msg: "Wudica sent me a read request 💌")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if request.characteristic == motionDataCharacteristic {
                // The watchOS app wrote to the motion data characteristic, read the new value.
                if let data = request.value {
                    // Use the motion data in your macOS app.
                    var arr2 = Array<Double>(repeating: 0, count: data.count/MemoryLayout<UInt32>.stride)
                    _ = arr2.withUnsafeMutableBytes { data.copyBytes(to: $0) }
                    addPosition(gravity: simd_quatd(ix: arr2[0], iy: arr2[1], iz: arr2[2], r: 0), rotation: simd_quatd(ix: arr2[4], iy: arr2[5], iz: arr2[6], r: arr2[3]))
                }
            }
        }
    }
    
    public func addPosition(gravity: simd_quatd, rotation: simd_quatd) {
        smartWatchGravityEntries.append(gravity)
        smartWatchRotationEntries.append(rotation)
        if smartWatchPointVector == nil { smartWatchPointVector = gravity }
        if let smartWatchPointVector = smartWatchPointVector {
            let result = rotation * smartWatchPointVector * rotation.conjugate
            positions.append(Position(x: result.vector.x, y: result.vector.y, z: result.vector.z))
        }
    }

}
