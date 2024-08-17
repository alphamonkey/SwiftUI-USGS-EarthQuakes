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
}
