//
//  ContentView.swift
//  LearnMapKitiOS17
//
//  Created by tom hackbarth on 6/19/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var placeAPin = false
    @State var pinLocation :CLLocationCoordinate2D? = nil
    
    var body: some View {
        NavigationView {
            VStack{
                Map{
                    if let pl = pinLocation {
                        Marker("here", coordinate: pl)
                    }
                }
                .onTapGesture(perform: { pt in
                    if (placeAPin){
                        // Need to get the location coord from map
                        
                        pinLocation = CLLocationCoordinate2D(latitude: 39.742043, longitude: -104.991531)
                        
                    }
                    placeAPin = false
                })
                .mapStyle(.standard(elevation: .realistic))
                
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

#Preview {
    ContentView()
}


