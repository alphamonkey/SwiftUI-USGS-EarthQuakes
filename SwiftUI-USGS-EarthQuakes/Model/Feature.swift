//
//  Feature.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import Foundation

struct Feature: Codable {
    let type:String
    let properties:FeatureProperties
    let geometry:FeatureGeometry
    let id:String
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
