//
//  UtilityFunctions.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/17/24.
//

import Foundation

struct UtilityFunctions {
    static func defaultDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }
    
    static func shortDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
    
    static func defaultDateString(_ date:Date) -> String {
        let dateFormatter = UtilityFunctions.defaultDateFormatter()
        return dateFormatter.string(from: date)
    }
    
    static func shortDateString(_ date:Date) -> String {
        let dateFormatter = UtilityFunctions.shortDateFormatter()

        return dateFormatter.string(from: date)
    }
    
    static func nlsDateString(_ date:Date) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.includesApproximationPhrase = true
        formatter.includesTimeRemainingPhrase = false
        return formatter.string(from: date, to: Date())
    }
}

extension Double {
    func metersToMiles() -> Double {
        return self * 0.000621371
    }
    func milesToKilometers() -> Double {
        return self * 1.6
    }
}
