//
//  FeatureCollection.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import Foundation

struct FeatureCollection: Codable {
    let type:String
    let metadata:FeatureMetaData
    let features:[Feature]
}
