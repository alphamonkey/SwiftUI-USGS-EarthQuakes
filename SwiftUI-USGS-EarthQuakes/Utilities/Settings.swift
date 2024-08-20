//
//  Settings.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/20/24.
//

import Foundation
let DefaultSettings:[Settings:Double] = [.minMag:1.0, .daysAgo:1.0, .maxRadius:50.0]

enum Settings:String {
    case minMag = "minmag"
    case daysAgo = "daysago"
    case maxRadius = "maxradius"

    func get() -> Double {
        
        guard let retVal = UserDefaults.standard.value(forKey: self.rawValue) as? Double else {
            return DefaultSettings[self]!
        }
        
        return retVal
        
    }
    
    func set(_ value:Double) {
        UserDefaults.standard.setValue(value, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
}


