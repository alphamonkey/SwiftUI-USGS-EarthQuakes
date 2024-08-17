//
//  FeatureMetaData.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import Foundation

struct FeatureMetaData:Codable {
    let generated:TimeInterval
    let url:String
    let title:String
    let status:Int
    let api:String
    let count:Int
}
