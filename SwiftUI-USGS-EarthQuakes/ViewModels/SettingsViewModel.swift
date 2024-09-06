//
//  SettingsViewModel.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 9/5/24.
//

import SwiftUI

@Observable class SettingsViewModel  {
    
    var radiusSliderValue = Settings.maxRadius.get()
    var daysAgoSliderValue = Settings.daysAgo.get()
    var minMagSliderValue = Settings.minMag.get()
    
    var maxRadius:Double {
        get {
            return Settings.maxRadius.get()
        }
        
        set {
            Settings.maxRadius.set(newValue)
        }
    }
    
    var daysAgo:Double {
        get {
            return Settings.daysAgo.get()
        }
        
        set {
            Settings.daysAgo.set(newValue)
        }
    }
    
    var minMag:Double {
        get {
            return Settings.minMag.get()
        }
        set {
            Settings.minMag.set(newValue)
        }
    }
    
}
