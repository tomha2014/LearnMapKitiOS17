//
//  TouchPoint.swift
//  LearnMapKitiOS17
//
//  Created by tom hackbarth on 1/5/24.
//

import Foundation
import CoreLocation

class TouchPoint: Identifiable{
    
    public var id = UUID()
    public var point: CLLocationCoordinate2D
    public var title: String = ""
    
    init(point: CLLocationCoordinate2D, title: String = "") {
        self.point = point
        self.title = title
    }
}

extension TouchPoint{
    static var denver = TouchPoint(point: CLLocationCoordinate2D(latitude: 39.742043, longitude: -104.991531), title: "Point 0")
    static var point1 = TouchPoint(point: CLLocationCoordinate2D(latitude: 39.7426288, longitude: -104.99356), title: "Point 1")
    static var point2 = TouchPoint(point: CLLocationCoordinate2D(latitude: 39.7419644069, longitude: -104.992850256), title: "Point 2")
    static var point3 = TouchPoint(point: CLLocationCoordinate2D(latitude: 39.741368712, longitude: -104.9918836925), title: "Point 3")
    static var point4 = TouchPoint(point: CLLocationCoordinate2D(latitude: 39.740662408, longitude: -104.9910427926), title: "Point 4")
    static var point5 = TouchPoint(point: CLLocationCoordinate2D(latitude: 39.7414641, longitude: -104.989724366), title: "Point 5")
}
