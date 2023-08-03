//
//  ContentView.swift
//  LearnMapKitiOS17
//
//  Created by tom hackbarth on 6/19/23.
//
//https://medium.com/@alessandromanilii/swiftui-add-mapmarkers-with-longpressgesture-part-1-31f55a87bef8

import SwiftUI
import MapKit

struct ContentView: View {
    @State var placeAPin = false
    @State var pinLocation :CLLocationCoordinate2D? = nil
    
    @State private var cameraProsition: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: .denver,
            distance: 3729,
            heading: 92,
            pitch: 70
        )
    )
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                VStack{
                    MapReader{ reader in
                        Map(
                            position: $cameraProsition,
                            interactionModes: .all
                        )
                        {
                            if let pl = pinLocation {
                                Marker("(\(pl.latitude), \(pl.longitude))", coordinate: pl)
                            }
                        }
                        .onTapGesture(perform: { screenCoord in
                            pinLocation = reader.convert(screenCoord, from: .local)
                            placeAPin = false
                        })
                        
                        .mapControls{
                            MapCompass()
                            MapScaleView()
                            MapPitchToggle()
                        }
                        
                        .mapStyle(.standard(elevation: .automatic))
                    }
                    
                }
                .navigationTitle("Map View")
                .toolbar {
                    if !placeAPin{
                        Button("Place a Pin") {
                            placeAPin = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

