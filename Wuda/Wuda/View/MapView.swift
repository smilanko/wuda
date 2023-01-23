//
//  MapView.swift
//  Wuda
//
//  Created by Slobodan Milanko
//

import SwiftUI

struct MapView: View {
    
    @ObservedObject private var mapController = MapController.shared
    @State private var pointColor = Color(.sRGB, red: 122/255, green: 39/255, blue: 161/255)
    
    var body: some View {
        VStack {
            HStack {
                ColorPicker("Color", selection: $pointColor)
                Button() {
                    pointColor = Color.random
                } label: {
                    Text("Random")
                    Image(systemName: "wand.and.stars")
                }
                Button {
                    // clear the face map
                    mapController.clearMap()
                } label: {
                    Text("Clear Map")
                    Image(systemName: "trash.square.fill").foregroundColor(.red)
                }
            }
            
            // map of faces
            let totalEntries = Double(mapController.faces.filter({ $0.count > 0 }).count)
            LazyHGrid(rows: mapController.rows, alignment: .center, spacing: 0, pinnedViews: [], content: {
                ForEach(mapController.faces) { face in
                    ZStack {
                        Square(color: pointColor.opacity(face.count / totalEntries )).border(.black.opacity(0.2))
                        Text("\(face.id)").opacity(0.7)
                    }
                }.background(Color(Constants.atmosphereColor).opacity(0.15))
            }).frame(maxWidth: .infinity)
        }.padding()
    }
}
