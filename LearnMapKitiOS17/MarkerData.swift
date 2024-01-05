//
//  MarkerData.swift
//  LearnMapKitiOS17
//
//  Created by tom hackbarth on 1/4/24.
//

import Foundation
import MapKit

private let rectWidth: Double = 40

struct MarkerData {
    let coordinate: CLLocationCoordinate2D
    let screenPoint: CGPoint
    var touchableRect: CGRect {
        .init(x: screenPoint.x - rectWidth / 2, y: screenPoint.y - rectWidth / 2, width: rectWidth, height: rectWidth)
    }
}
