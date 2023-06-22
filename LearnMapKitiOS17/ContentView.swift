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
                    Map(
                        position: $cameraProsition,
                        interactionModes: .all
                    )
                    {
                        if let pl = pinLocation {
                            Marker("here", coordinate: pl)
                        }
                    }
                    .onTapGesture(perform: { screenCoord in
//                        if (placeAPin){
                            print(screenCoord)
                            // Need to convert screenCoord to MapCoord
                            // Need to get the location coord from map
                            pinLocation = .denver
//                        }
                        placeAPin = false
                    })
                    
                    .mapControls{
                        MapCompass()
                        MapScaleView()
                        MapPitchButton()
                    }
                    .mapStyle(.standard(elevation: .automatic))
                    
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

//private extension ContentView {
//
//    func convertTap(at point: CGPoint, for mapSize: CGSize) -> CLLocationCoordinate2D {
//
//        let lat = cameraProsition.camera?.centerCoordinate.latitude
//        let lon = cameraProsition.camera?.centerCoordinate.longitude
//        let mapCenter = CGPoint(x: mapSize.width/2, y: mapSize.height/2)
//
//        // X
//        let xValue = (point.x - mapCenter.x) / mapCenter.x
//        let xSpan = xValue * region.span.longitudeDelta/2
//
//        // Y
//        let yValue = (point.y - mapCenter.y) / mapCenter.y
//        let ySpan = yValue * region.span.latitudeDelta/2
//
//        return CLLocationCoordinate2D(latitude: lat! - ySpan, longitude: lon! + xSpan)
//
//    }
//}
