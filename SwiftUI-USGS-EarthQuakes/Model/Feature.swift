//
//  Feature.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import Foundation
import CoreLocation
import SwiftUI

struct Feature: Codable {
    let type:String
    let properties:FeatureProperties
    let geometry:FeatureGeometry
    let id:String
    
    var url:URL {
        return URL(string:"usgsearthquake://\(self.id)")!
    }
    
    var location:CLLocation {
        return CLLocation(latitude: self.geometry.coordinates[1], longitude: self.geometry.coordinates[0])
    }
    var shortPlace:String {
        return String(self.properties.place.split(separator:" of ")[1])
    }
    var date:Date {
        return Date(timeIntervalSince1970: self.properties.time / 1000)
    }
    static var mockFeature:Feature {
        get {
            let type = "earthquake"
            let featureProperties = FeatureProperties(place: "1 km NNE of Somewhere", mag: 5.0, time: 1724146722, updated: 1724146722, tz: nil, url: "https://example.com", felt: nil, cdi: nil, mmi: nil, alert: nil, status: "Automatic", tsunami: 0, sig: 55, code: "foobarbaz", sources: "test", types: "earthquake", nst: 0, dmin: 0.0, rms: 0.0, gap: 0.0, magType: "richter")
            let id = "0x00000"
            let geometry = FeatureGeometry(type: "Point", coordinates: [-122.4786, 37.8199])
            return Feature(type: type, properties: featureProperties, geometry: geometry, id: id)
        }
    }
    
    var magColor:Color {
        switch self.properties.mag {
        case let x where x < 3.0:
            return Color.lowMag
        case let x where x >= 3.0 && x < 6.0:
            return Color.medMag
        case let x where x >= 6.0:
            return Color.highMag
        default:
            return Color.black
        }

        
        
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
