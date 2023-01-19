//
//  OrientationCoordinator.swift
//  Wudica Watch App
//
//  Created by Slobodan Milanko
//

import Foundation
import WatchKit

class OrientationCoordinator {
    
    func standardize(wristLocation: WKInterfaceDeviceWristLocation, crownLocation: WKInterfaceDeviceCrownOrientation ) -> Double {
        if wristLocation == .left {
            return crownLocation == .right ? 0.0 : 1.0;
        } else {
            return crownLocation == .right ? 2.0 : 3.0;
        }
    }
    
}
