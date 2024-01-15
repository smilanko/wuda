import Foundation
import CoreBluetooth
import SwiftUI
import simd

final class MotionController: NSObject, ObservableObject, CBPeripheralManagerDelegate, Action {

    @Published private(set) var history: [History] = []
    @Published private(set) var pauseDataUpdates: Bool = false
    @Published private(set) var smartDeviceOrientation: Double?
    @Published private(set) var quaternionShift: simd_quatd?
    public var point: simd_quatd? { SessionState.shared.defaultPoint.toSimd() }
    
    private var smartDevicePosition: simd_quatd?
    private var peripheralManager: CBPeripheralManager!
    private var motionService: CBMutableService!
    private var motionDataCharacteristic: CBMutableCharacteristic!

    public static let shared = MotionController()
    
    private override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            motionService = CBMutableService(type: Constants.wudaPeripheralService, primary: true)
            motionDataCharacteristic = CBMutableCharacteristic(type: Constants.wudaPeripheralMotionCharacteristicUuid, properties: [.writeWithoutResponse, .notify], value: nil, permissions: [.writeable, .readable])
            motionService.characteristics = [motionDataCharacteristic]
            peripheralManager.add(motionService)
            peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [Constants.wudaPeripheralService]])
            LogController.shared.log(level: .info, msg: "Advertising to wudica")
        case .poweredOff, .resetting, .unauthorized, .unsupported:
            peripheralManager.stopAdvertising()
            LogController.shared.log(level: .info, msg: "Advertising end -> (\(peripheral.state.description). Bye wudica")
        default:
            LogController.shared.log(level: .warning, msg: "Unknown ble state -> \(peripheral.state.description)")
            break
        }
    }
    
    public func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        LogController.shared.log(level: .info, msg: "Wudica sent a read request")
    }
    
    public func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        guard !pauseDataUpdates else { return }
        requests.forEach({ request in
            if request.characteristic == motionDataCharacteristic, let data = request.value {
                var incomingStream = Array<Double>(repeating: 0, count: data.count/MemoryLayout<UInt32>.stride)
                _ = incomingStream.withUnsafeMutableBytes { data.copyBytes(to: $0) }
                guard incomingStream[0] != 0 else {
                    // this is the end signal from the smart device
                    smartDevicePosition = nil
                    LogController.shared.log(level: .info, msg: "Wudica sent a stop")
                    return
                }
                
                guard incomingStream[0] == 1 else {
                    // the first item is reserved for the state ( 1 running, 0 not running )
                    LogController.shared.log(level: .fatal, msg: "Wudica sent an unknown signal -> \(incomingStream[0])")
                    return
                }
                
                parse(stream: incomingStream)
            }
        })
    }
    
    public func clear() {
        history.removeAll()
    }
    
    public func toggle() {
        pauseDataUpdates.toggle()
    }
    
    public func apply(shift: simd_quatd?) {
        quaternionShift = shift
        guard let quaternionShift else {
            LogController.shared.log(level: .info, msg: "Quaternion shifting disabled")
            return
        }
        LogController.shared.log(level: .warning, msg: "shift=" + quaternionShift.formatted)
    }
    
    private func parse(stream: [Double]) {
        guard stream.count >= 10 else {
            LogController.shared.log(level: .fatal, msg: "Invalid Message -> \(stream.count) items")
            return
        }
        
        let message = Message(stream: stream)
        if smartDevicePosition == nil {
            smartDevicePosition = message.gravity
            LogController.shared.log(level: .info, msg: "Wudica sent a new init")
        }
        
        if let point {
            let result = quaternionShift != nil ? quaternionShift! * message.rotation * point * message.rotation.conjugate * quaternionShift!.conjugate : message.rotation * point * message.rotation.conjugate
            smartDeviceOrientation = message.orientation
            let norm = (result.vector.w * result.vector.w) + (result.vector.x * result.vector.x) + (result.vector.y * result.vector.y) + (result.vector.z * result.vector.z)
            let position = Position(x: result.vector.x, y: result.vector.y, z: result.vector.z, xAngle: getAngle(axis: result.vector.x, norm: norm), yAngle: getAngle(axis: result.vector.y, norm: norm), zAngle: getAngle(axis: result.vector.z, norm: norm))
            history.append(History(message: message, position: position))
        }
    }
    
    private func getAngle(axis: Double, norm: Double) -> Double {
        return Measurement(value: acos(axis / norm), unit: UnitAngle.radians).converted(to: .degrees).value
    }

}
