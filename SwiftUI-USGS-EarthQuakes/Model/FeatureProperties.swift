//
//  FeatureProperties.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import Foundation
struct FeatureProperties:Codable {
    let place:String
    let mag:Double
    let time:TimeInterval
    let updated:TimeInterval
    let tz:Int?
    let url:String
    let felt:Int?
    let cdi:Double?
    let mmi:Double?
    let alert:String?
    let status:String?
    let tsunami:Int?
    let sig:Int
    let code:String?
    let sources:String?
    let types:String?
    let nst:Int?
    let dmin:Double?
    let rms:Double?
    let gap:Double?
    let magType:String?
   
}
