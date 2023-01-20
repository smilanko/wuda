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
    @Published private(set) var pauseDataUpdates: Bool = false
    @Published private(set) var dataHistory : [History] = []
    
    private var wudaPeripheralService = CBUUID(string: "12345678-1234-1234-1234-123456789012")
    private var wudaPeripheralMotionCharacteristicUuid = CBUUID(string: "12345678-1234-1234-1234-123456789013")
    private var smartWatchGravityEntries : [simd_quatd] = []
    private var smartWatchRotationEntries : [simd_quatd] = []
    
    private var initialSmartWatchPosition : simd_quatd?
    private var quaternionShift : simd_quatd?
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
        if pauseDataUpdates { return }
        for request in requests {
            if request.characteristic == motionDataCharacteristic {
                // The watchOS app wrote to the motion data characteristic, read the new value.
                if let data = request.value {
                    // Use the motion data in your macOS app.
                    var arr2 = Array<Double>(repeating: 0, count: data.count/MemoryLayout<UInt32>.stride)
                    _ = arr2.withUnsafeMutableBytes { data.copyBytes(to: $0) }
                    if arr2[0] == 0 {
                        // this is the end signal, i.e the user clicked stop on the smartwatch
                        // next time the user clicks start, they will provide the starting posion
                        initialSmartWatchPosition = nil
                        logController.addLogMessage(type: .info, msg: "Wudica sent a de-init!")
                        return
                    }
                    
                    if arr2[0] != 1 {
                        // the first item is reserved for the state ( 1 running, 0 not running )
                        fatalError("What signal is this?")
                    }
                    
                    let gravity: simd_quatd = simd_quatd(ix: arr2[1], iy: arr2[2], iz: arr2[3], r: 0)
                    let rotation: simd_quatd = simd_quatd(ix: arr2[5], iy: arr2[6], iz: arr2[7], r: arr2[4])
                    addPosition(gravity: gravity, rotation: rotation, orientation: arr2[8], ts: arr2[9])
                }
            }
        }
    }
    
    private func addPosition(gravity: simd_quatd, rotation: simd_quatd, orientation: Double, ts: Double) {
        smartWatchGravityEntries.append(gravity)
        smartWatchRotationEntries.append(rotation)
        if initialSmartWatchPosition == nil {
            initialSmartWatchPosition = gravity
            logController.addLogMessage(type: .info, msg: "Wudica sent an init!")
            
            if !positions.isEmpty || !dataHistory.isEmpty {
                logController.addLogMessage(type: .severe, msg: "Mixing data! Initial smartwatch position changed, yet memory holds old data!")
            }
        }
        if let initialSmartWatchPosition = initialSmartWatchPosition {
            var result = rotation * initialSmartWatchPosition * rotation.conjugate
            if let quaternionShift = quaternionShift {
                result = quaternionShift * result * quaternionShift.conjugate
            }
            let norm = (result.vector.x * result.vector.x) + (result.vector.y * result.vector.y) + (result.vector.z * result.vector.z)
            let position = Position(x: result.vector.x, y: result.vector.y, z: result.vector.z, xAngle: getAngle(axis: result.vector.x, norm: norm), yAngle: getAngle(axis: result.vector.y, norm: norm), zAngle: getAngle(axis: result.vector.z, norm: norm))
            positions.append(position)
            dataHistory.append(History(gravity: gravity, rotation: rotation, position: position, orientation: orientation, time: ts))
        }
    }
    
    private func getAngle(axis: Double, norm: Double) -> Double {
        return Measurement(value: acos(axis / norm), unit: UnitAngle.radians).converted(to: .degrees).value
    }
    
    public func clearMemory() {
        dataHistory.removeAll()
        positions.removeAll()
    }
    
    public func toggleUpdates() {
        pauseDataUpdates.toggle()
    }
    
    public func updateShift(x: Double, y: Double, z: Double) {
        if x != 0 {
            let radX = Measurement(value: x, unit: UnitAngle.degrees).converted(to: .radians).value / 2.0
            quaternionShift = simd_quatd(ix: sin(radX), iy: 0, iz: 0, r: cos(radX))
            logController.addLogMessage(type: .warning, msg: quaternionShift!.prettyPrint)
            return
        }
        
        if y != 0 {
            let radY = Measurement(value: y, unit: UnitAngle.degrees).converted(to: .radians).value / 2.0
            quaternionShift = simd_quatd(ix: 0, iy: sin(radY), iz: 0, r: cos(radY))
            logController.addLogMessage(type: .warning, msg: quaternionShift!.prettyPrint)
            return
        }
        
        if z != 0 {
            let radZ = Measurement(value: z, unit: UnitAngle.degrees).converted(to: .radians).value / 2.0
            quaternionShift = simd_quatd(ix: 0, iy: 0, iz: sin(radZ), r: cos(radZ))
            logController.addLogMessage(type: .warning, msg: quaternionShift!.prettyPrint)
            return
        }
        
        // convert angle to rads
        logController.addLogMessage(type: .info, msg: "Quaternion shifting disabled")
        quaternionShift = nil
        return
    }

}
