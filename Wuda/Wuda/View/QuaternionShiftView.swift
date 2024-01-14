import SwiftUI
import simd

struct QuaternionShiftView: View {
    
    @ObservedObject private var motionController = MotionController.shared
    @State private var shifts : [QuaternionShift] = []

    @State private var isConjugate: Bool = false
    @State private var selectedAxis: Axis = .x
    @State private var angle: Double = 0

    
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
                Picker("", selection: $selectedAxis) {
                    ForEach(Axis.allCases, id: \.self) { axis in
                        Text(axis.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Stepper(value: $angle, in: 0...360) {
                    Text("\(String(format: "%.0f", angle))\u{00B0}")
                }

                Toggle(isOn: $isConjugate) {
                    Text("Conjugate")
                }.toggleStyle(.checkbox)
                
                    
                Button {
                    let q = simd_quatd.buildQuaternionForRotation(angle: angle, axis: selectedAxis)
                    shifts.append(QuaternionShift(q: isConjugate ? q.conjugate : q))
                    angle = 0
                } label: {
                    Text("Add")
                    Image(systemName: "plus.square.fill.on.square.fill")
                }
                .disabled(angle < 1)
                .help("You can apply additional rotations to your signal using quaternions. Select an axis and the number of degrees to rotate by. If you want a counter-clockwise rotation, remember to check the Conjugate box. Click Add to add the quaternion to the stack. You can add as many as you'd like.")
            }
            
            List(shifts, id:\.id) { shift in
                HStack {
                    Text(shift.q.formatted).frame(maxWidth: .infinity, alignment: .leading)
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
            VStack {
                (Text("p = ") + Text("\(motionController.point?.formatted ?? "(will update)")"))
                (Text("q = ") + Text(motionController.quaternionShift?.formatted ?? "(none)"))
                (Text("qpq' = ") + Text(motionController.permutedResult?.formatted ?? "(dynamic)"))
                (Text("orientation = ") + Text(String(motionController.smartwatchOrientation ?? 0)))
            }
            Divider()
            // store to memory
            HStack {
                Text("Copy the activity name and the final quaternion (qpq') to your device's memory.").multilineTextAlignment(.center)
            }
            HStack {
                TextField("activity", text: $motionController.activityName)
                Button {
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString(motionController.activityName + ", q=" + (motionController.permutedResult?.formatted ?? ""), forType: .string)
                } label: {
                    Text("Copy")
                    Image(systemName: "paintbrush.fill")
                }
            }
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
