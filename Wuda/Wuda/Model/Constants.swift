import CoreBluetooth
import Foundation
import SwiftUI

struct Constants {
    
    private init() {}
    
    public static let squareSize: CGFloat = 15.0
    public static let defaultGeodasicPattern: IcosahedronPattern = .geodasicPattern4
    
    public static let rootNodeConstant = "ozone"
    public static let rootNodeForGeodasicMap = "geodesicIcosahedron"
    public static let rootNodeForTelescope = "telescope"
    public static let rootNodeForAngles = "angles"
    
    public static let wudaPeripheralService = CBUUID(string: "12345678-1234-1234-1234-123456789012")
    public static let wudaPeripheralMotionCharacteristicUuid = CBUUID(string: "12345678-1234-1234-1234-123456789013")
    
    public static let gradientStartColor = NSColor(red: 255/255,green: 206/255,blue: 97/255, alpha: 1.0)
    public static let gradientEndColor = NSColor(red: 191/255, green: 52/255, blue: 117/255, alpha: 1.0)
    public static let atmosphereColor = NSColor(red: 192/255, green: 210/255, blue: 218/255, alpha: 1)
    
}
