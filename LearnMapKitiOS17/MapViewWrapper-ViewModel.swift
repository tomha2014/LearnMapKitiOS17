//
//  MapViewWrapper-ViewModel.swift
//  LearnMapKitiOS17
//
//  Created by tom hackbarth on 1/4/24.
//

import Foundation
import MapKit

extension MapViewWrapper{
    @MainActor class ViewModel: ObservableObject{
        
        @Published  var isMarkerDragging = false
        @Published  var markerText = "Spot"
        @Published  var selectPointIndex = -1
                
        @Published var points: [CLLocationCoordinate2D] = [.point1, .point2, .point3, .point4, .point5]
        
        @Published var touchPoints: [TouchPoint] = [.point1, .point2, .point3, .point4, .point5]
                
        public func updatePointByIndex(index:Int, coord: CLLocationCoordinate2D) {            
            points[index] = coord
        }
        
        public func buildString(markerData: MarkerData?) -> String{
            guard let cord = markerData else {return "--"}
            return "\(cord.coordinate.latitude), \(cord.coordinate.longitude)"
        }
    }
}
