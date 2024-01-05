//
//  MapViewWrapper.swift
//  LearnMapKitiOS17
//
//  Created by tom hackbarth on 10/4/23.
//
// My Question:
// https://stackoverflow.com/questions/77754258/on-ios-with-mapkit-multible-how-do-display-markers


import MapKit
import SwiftUI

struct MapViewWrapper: View {
    
    @StateObject private var viewModel = ViewModel()

    @State private var cameraPosition: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: .denver,
            distance: 3729,
            heading: 92,
            pitch: 70
        )
    )
    
    @State private var modes: MapInteractionModes = [.all]
    @State private var markerData: MarkerData?
    @State private var markers: [MarkerData] = []

    var body: some View {
        VStack(){
            VStack{
                GeometryReader { geometryProxy in
                    MapReader { mapProxy in
                        Map(position: $cameraPosition, interactionModes: modes) {
                            if let markerData {
                                Marker(viewModel.markerText, coordinate: markerData.coordinate)
                            }

                            ForEach(viewModel.touchPoints) { marker in
                                Marker(marker.title, coordinate: marker.point)
                            }

                            let points = viewModel.touchPoints.map { $0.point }

                            MapPolyline(coordinates: points,
                                        contourStyle: MapPolyline.ContourStyle.straight)
                            .mapOverlayLevel(level: .aboveLabels)
                            .stroke(.red, lineWidth: 4)
                            .tint(.pink)
                        }
                        .onTapGesture { screenCoordinate in
                            self.markerData = mapProxy.markerData(screenCoordinate: screenCoordinate, geometryProxy: geometryProxy)
                            if let md = self.markerData{
                                viewModel.addMarkerData(marker: md)
                            }
                        }
                        .highPriorityGesture(DragGesture(minimumDistance: 1)
                            .onChanged { drag in
                                if (markerData == nil) {
                                    for (index, pt) in viewModel.touchPoints.enumerated() {
                                        let m = mapProxy.markerData(coordinate: pt.point, geometryProxy: geometryProxy)
                                        if (m!.touchableRect.contains(drag.startLocation)){
                                            self.markerData = m
                                            viewModel.selectPointIndex = index
                                            viewModel.markerText = "Dragging"
                                        }
                                    }
                                }
                                guard let markerData else{ return }

                                if viewModel.isMarkerDragging {

                                } else if markerData.touchableRect.contains(drag.startLocation) {
                                    viewModel.isMarkerDragging = true
                                    setMapInteraction(enabled: false)
                                } else {
                                    return
                                }

                                self.markerData = mapProxy.markerData(screenCoordinate: drag.location, geometryProxy: geometryProxy)
 
                            }
                            .onEnded { drag in
                                setMapInteraction(enabled: true)
                                viewModel.isMarkerDragging = false
                                if (viewModel.selectPointIndex > -1){
                                    viewModel.updatePointByIndex(index: viewModel.selectPointIndex, coord: markerData!.coordinate)
                                    viewModel.selectPointIndex = -1
                                    self.markerData = nil
                                }
                            }
                        )
                        .onMapCameraChange {
                            guard let markerData else { return }
                            self.markerData = mapProxy.markerData(coordinate: markerData.coordinate, geometryProxy: geometryProxy)
                        }
                    }
                }
            }
            .onAppear(){
            }
        }
    }
}

private extension MapViewWrapper{

    
    private func setMapInteraction(enabled: Bool) {
        if enabled {
            modes = .all
        } else {
            modes = []
        }
    }
}

private extension MapProxy {
    
    func markerData(screenCoordinate: CGPoint, geometryProxy: GeometryProxy) -> MarkerData? {
        guard let coordinate = convert(screenCoordinate, from: .local) else { return nil }
        return .init(coordinate: coordinate, screenPoint: screenCoordinate)
    }
    
    func markerData(coordinate: CLLocationCoordinate2D, geometryProxy: GeometryProxy) -> MarkerData? {
        guard let point = convert(coordinate, to: .local) else { return nil }
        return .init(coordinate: coordinate, screenPoint: point)
    }
}
