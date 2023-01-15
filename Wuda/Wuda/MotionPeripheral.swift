//
//  MotionPeripheral.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import CoreBluetooth
import SceneKit
import SwiftUI
import simd

class MotionPeripheral: NSObject, ObservableObject, CBPeripheralManagerDelegate {

    @ObservedObject private var experimentState = ExperimentState.shared
    @Published private(set) var point: SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
    @Published private(set) var planeAngle: SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
    @Published private(set) var pointVector: simd_quatd?
    
    private var wudaPeripheralService = CBUUID(string: "12345678-1234-1234-1234-123456789012")
    private var wudaPeripheralMotionCharacteristicUuid = CBUUID(string: "12345678-1234-1234-1234-123456789013")
    private var peripheralManager: CBPeripheralManager!
    private var motionService: CBMutableService!
    private var motionDataCharacteristic: CBMutableCharacteristic!

    public static let shared = MotionPeripheral()
    
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
            experimentState.addLogMessage(type: .info, msg: "Advertising to wudica 🥰")
        case .poweredOff, .resetting, .unauthorized, .unsupported:
            // Stop advertising the service.
            peripheralManager.stopAdvertising()
            experimentState.addLogMessage(type: .info, msg: "Stopping service. Bye wudica 🛌")
        default:
            break
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        experimentState.addLogMessage(type: .info, msg: "Wudica sent me a read request 💌")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if request.characteristic == motionDataCharacteristic {
                // The watchOS app wrote to the motion data characteristic, read the new value.
                if let data = request.value {
                    // Use the motion data in your macOS app.
                    var arr2 = Array<Double>(repeating: 0, count: data.count/MemoryLayout<UInt32>.stride)
                    _ = arr2.withUnsafeMutableBytes { data.copyBytes(to: $0) }
                    if let pointVector = pointVector {
                        let q = simd_quatd(ix: arr2[4], iy: arr2[5], iz: arr2[6], r: arr2[3])
                        let result = q * pointVector * q.conjugate
                        let pNorm = sqrt(pow(result.vector.w, 2) + pow(result.vector.x, 2) + pow(result.vector.y, 2) + pow(result.vector.z, 2))
                        self.point = SCNVector3(x: result.vector.x, y: result.vector.y, z: result.vector.z)
                        self.planeAngle = SCNVector3(x: getPlaneAngle(axis: result.vector.x, pNorm: pNorm), y: getPlaneAngle(axis: result.vector.y, pNorm: pNorm), z: getPlaneAngle(axis: result.vector.z, pNorm: pNorm))
                    } else {
//                        pointVector = simd_quatd(ix: -1, iy: 0, iz: 0, r: 0) // static
                        pointVector = simd_quatd(ix: arr2[0], iy: arr2[1], iz: arr2[2], r: 0) // gravity
                    }
                }
            }
        }
    }
    
    private func getPlaneAngle(axis: Double, pNorm: Double) -> Double {
        let val = experimentState.trigSelection == WudaConstants.cosFunction ? acos(axis / pNorm) : asin(axis / pNorm)
        return Measurement(value: val, unit: UnitAngle.radians).converted(to: .degrees).value
    }
}
