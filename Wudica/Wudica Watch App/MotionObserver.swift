//
//  MotionObserver.swift
//  Wudica Watch App
//
//  Created by Slobodan Milanko
//

import Foundation
import CoreMotion
import CoreBluetooth
import HealthKit

class MotionObserver : NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @Published private(set) var w: Double = 0.0
    @Published private(set) var x: Double = 0.0
    @Published private(set) var y: Double = 0.0
    @Published private(set) var z: Double = 0.0

    private var motionManager: CMMotionManager = CMMotionManager()
    private let healthStore = HKHealthStore()
    
    private var peripheralManager: CBCentralManager!
    private var motionPeripheral: CBPeripheral!
    private var transferCharacteristic: CBMutableCharacteristic!
    private var motionCharacteristic: CBCharacteristic?
    private var workoutSession: HKWorkoutSession?
    
    private var wudaPeripheralService: String = "12345678-1234-1234-1234-123456789012"
    private var wudaPeripheralMotionCharacteristic: String = "12345678-1234-1234-1234-123456789013"

    override init() {
        super.init()
        peripheralManager = CBCentralManager(delegate: self, queue: nil)

        do {
            let workoutConfiguration = HKWorkoutConfiguration()
            workoutConfiguration.activityType = .highIntensityIntervalTraining
            workoutConfiguration.locationType = .unknown
            workoutSession = try HKWorkoutSession(healthStore: healthStore, configuration: workoutConfiguration)
            workoutSession!.startActivity(with: Date())
        } catch {
            print("## error:: \(error)")
        }
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: .main) { (motion, error) in
                guard let motion = motion else {
                    return
                }
                self.w = motion.attitude.quaternion.w
                self.x = motion.attitude.quaternion.x
                self.y = motion.attitude.quaternion.y
                self.z = motion.attitude.quaternion.z
                self.send(motionData: [motion.attitude.quaternion.w, motion.attitude.quaternion.x, motion.attitude.quaternion.y, motion.attitude.quaternion.z])
            }
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("## powered on, so scanning")
            peripheralManager.scanForPeripherals(withServices: [CBUUID(string: wudaPeripheralService)])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        motionPeripheral = peripheral
        motionPeripheral.delegate = self
        central.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("## looking for the wuda service");
        peripheral.discoverServices([CBUUID(string: wudaPeripheralService)])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        print("## we found a service");
        for service in services {
            peripheral.discoverCharacteristics([CBUUID(string: wudaPeripheralMotionCharacteristic)], for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        print("## we discovered characterisitcs");
        for characteristic in characteristics {
            motionCharacteristic = characteristic
            motionPeripheral.setNotifyValue(true, for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("## we tried to send: \(error.debugDescription )")
    }
    
    func send(motionData: [Double]) {
        guard let characteristic = motionCharacteristic else { return }
        let data = motionData.withUnsafeBufferPointer { buffer in
            return Data(buffer: buffer)
        }
        motionPeripheral.writeValue(data, for: characteristic, type: .withoutResponse)
    }

}
