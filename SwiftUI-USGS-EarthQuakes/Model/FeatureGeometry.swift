//
//  FeatureGeometry.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import Foundation


struct FeatureGeometry:Codable {
    let type:String
    let coordinates:[Double]
}
