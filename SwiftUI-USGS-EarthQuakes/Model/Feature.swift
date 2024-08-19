//
//  Feature.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import Foundation
import CoreLocation
struct Feature: Codable {
    let type:String
    let properties:FeatureProperties
    let geometry:FeatureGeometry
    let id:String
    
    var location:CLLocation {
        return CLLocation(latitude: self.geometry.coordinates[1], longitude: self.geometry.coordinates[0])
    }
}


extension Feature: Equatable {
    static func == (lhs: Feature, rhs: Feature) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Feature:Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(type)
    }
}
