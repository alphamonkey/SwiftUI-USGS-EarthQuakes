//
//  EarthQuakeWidget.swift
//  EarthQuakeWidget
//
//  Created by Josh Edson on 9/6/24.
//

import WidgetKit
import SwiftUI




struct EarthQuakeWidget: Widget {
    let kind: String = "EarthQuakeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                EarthQuakeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                EarthQuakeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("USGS Earthquakes Widget")
        .description("Widget that displays the highest magnitude earthquake near you")
        .supportedFamilies([.systemSmall])
        
    }
}

#Preview(as: .systemSmall) {
    EarthQuakeWidget()
} timeline: {
    FeatureEntry(date: .now,  feature:Feature.mockFeature)
    FeatureEntry(date: .now,  feature:Feature.mockFeature)
}
