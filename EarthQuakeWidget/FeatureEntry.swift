//
//  FeatureEntry.swift
//  EarthQuakeWidgetExtension
//
//  Created by Josh Edson on 9/6/24.
//

import WidgetKit
import SwiftUI

struct FeatureEntry: TimelineEntry {
    let date: Date
    let feature:Feature
    var image:UIImage?
    var distance:Int?
    init(date:Date, feature:Feature) {
        self.date = date
        self.feature = feature
    }
}
