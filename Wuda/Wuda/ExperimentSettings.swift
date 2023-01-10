//
//  ExperimentSettings.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import Foundation
import SwiftUI

class ExperimentSettings: ObservableObject {
    
    @Published var axisSelection = WudaConstants.xAxis
    @Published var trigSelection = WudaConstants.cosFunction
    @Published var pointSelection = WudaConstants.quatPointXMinStr
    @Published var canUpdatePoints : Bool = true
    @Published var pointColor = Color(.sRGB, red: 122/255, green: 39/255, blue: 161/255)
    @Published var clearScatterPlot: Bool = true
    
    public let axisOptions = [WudaConstants.xAxis, WudaConstants.yAxis, WudaConstants.zAxis]
    public let trigOptions = [WudaConstants.cosFunction, WudaConstants.sinFunction]
    public let pointOptions = [WudaConstants.quatPointXMin, WudaConstants.quatPointXPlus, WudaConstants.quatPointYMin, WudaConstants.quatPointYPlus, WudaConstants.quatPointZMin, WudaConstants.quatPointZPlus]
    public let pointOptionStrings = [WudaConstants.quatPointXMinStr, WudaConstants.quatPointXPlusStr, WudaConstants.quatPointYMinStr, WudaConstants.quatPointYPlusStr, WudaConstants.quatPointZMinStr, WudaConstants.quatPointZPlusStr]
    
    public static var shared = ExperimentSettings()
    
    private init() {}
    
}
