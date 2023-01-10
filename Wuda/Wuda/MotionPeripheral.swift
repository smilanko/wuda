//
//  MotionPeripheral.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import CoreBluetooth
import SceneKit
import simd

class MotionPeripheral: NSObject, ObservableObject, CBPeripheralManagerDelegate {
    
    private var wudaPeripheralService = CBUUID(string: "12345678-1234-1234-1234-123456789012")
    private var wudaPeripheralMotionCharacteristicUuid = CBUUID(string: "12345678-1234-1234-1234-123456789013")
    
    private var peripheralManager: CBPeripheralManager!
    private var motionService: CBMutableService!
    private var motionDataCharacteristic: CBMutableCharacteristic!
    private let quatPoint = simd_quatd(ix: 0, iy: 0, iz: -1, r: 0)
    
    @Published private(set) var point: SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
    
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
            motionDataCharacteristic = CBMutableCharacteristic(type: wudaPeripheralMotionCharacteristicUuid, properties: [.writeWithoutResponse, .notify], value: nil, permissions: [.writeable])
            motionService.characteristics = [motionDataCharacteristic]
            // Add the service to the peripheral manager.
            peripheralManager.add(motionService)
            // Start advertising the service.
            peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [wudaPeripheralService]])
            print("[INFO] Advertising")
        case .poweredOff, .resetting, .unauthorized, .unsupported:
            // Stop advertising the service.
            peripheralManager.stopAdvertising()
            print("[ERROR] Stopping service")
        default:
            break
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        print("[INFO] Received a read request");
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if request.characteristic == motionDataCharacteristic {
                // The watchOS app wrote to the motion data characteristic, read the new value.
                if let data = request.value {
                    // Use the motion data in your macOS app.
                    var arr2 = Array<Double>(repeating: 0, count: data.count/MemoryLayout<UInt32>.stride)
                    _ = arr2.withUnsafeMutableBytes { data.copyBytes(to: $0) }
                    let q = simd_quatd(ix: arr2[1], iy: arr2[2], iz: arr2[3], r: arr2[0])
                    let result = q * quatPoint * q.conjugate
                    self.point = SCNVector3(x: result.vector.x, y: result.vector.y, z: result.vector.z)
                }
            }
        }
    }
}
