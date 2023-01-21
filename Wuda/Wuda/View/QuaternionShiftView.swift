//
//  QuaternionShiftView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import SwiftUI
import simd

struct QuaternionShiftView: View {
    
    @ObservedObject private var motionController = MotionController.shared
    @State private var shifts : [QuaternionShift] = []

    @State private var isConjugate : Bool = false
    @State private var x : Double = 0
    @State private var y : Double = 0
    @State private var z : Double = 0
    
    
    var body: some View {
        VStack {
            Picker("Reference", selection: $motionController.defaultPoint) {
                Text(Reference.xminus.rawValue).tag(Reference.xminus)
                Text(Reference.yminus.rawValue).tag(Reference.yminus)
                Text(Reference.zminus.rawValue).tag(Reference.zminus)
                Text(Reference.xplus.rawValue).tag(Reference.xplus)
                Text(Reference.yplus.rawValue).tag(Reference.yplus)
                Text(Reference.zplus.rawValue).tag(Reference.zplus)
                Text(Reference.smartWatch.rawValue).tag(Reference.smartWatch)
            }
            Divider()
            HStack {
                Stepper(value: $x, in: 0...360) { Text("x:\(Int(x)),") }.disabled( y > 0 || z > 0)
                Stepper(value: $y, in: 0...360) { Text("y:\(Int(y)),") }.disabled( x > 0 || z > 0)
                Stepper(value: $z, in: 0...360) { Text("z:\(Int(z))") }.disabled( x > 0 || y > 0)
                Toggle(isOn: $isConjugate) {
                    Text("Conjugate")
                }.toggleStyle(CheckboxToggleStyle())
                    
                Button {
                    let q = simd_quatd.build(x: x, y: y, z: z)
                    shifts.append(QuaternionShift(q: isConjugate ? q.conjugate : q))
                    x = 0; y = 0; z = 0; isConjugate = false
                } label: {
                    Text("Add")
                    Image(systemName: "plus.square.fill.on.square.fill")
                }.disabled((x + y + z) == 0)
            }
            List(shifts, id:\.id) { shift in
                HStack {
                    Text(shift.q.prettyPrint).frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        var newArray : [QuaternionShift] = []
                        shifts.filter({ $0.id != shift.id }).forEach({ newArray.append($0) })
                        shifts = newArray
                    } label : {
                        Text("Delete")
                        Image(systemName: "trash.square.fill").foregroundColor(.red)
                    }
                }
            }
            Divider()
            // initial orientation
            (Text("p = ") + Text("\(motionController.getPoint()?.prettyPrint ?? "(unknown)")"))
            (Text("shift = ") + Text(motionController.quaternionShift?.prettyPrint ?? "(none)"))
        }.padding()
        .onChange(of: shifts, perform: { newShifts in
            if newShifts.isEmpty {
                motionController.updateShift(q: nil)
                return
            }
            var updatedShift = newShifts[0].q
            for idx in 1..<newShifts.count {
                updatedShift = updatedShift * newShifts[idx].q
            }
            motionController.updateShift(q: updatedShift)
        })
    }

}
