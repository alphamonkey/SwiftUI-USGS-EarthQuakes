//
//  FeatureListItemView.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/20/24.
//

import SwiftUI
import CoreLocation
struct FeatureListItemView: View {
    let feature:Feature
    let currentLocation:CLLocation?
    
    init(_ feature: Feature, currentLocation:CLLocation?) {
        self.feature = feature
        self.currentLocation = currentLocation
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading)
             {
                 Text(feature.shortPlace).font(.subheadline).bold()
                 HStack {
                     Text(UtilityFunctions.shortDateString(feature.date)).font(.footnote).foregroundStyle(Color.secondary)
                     Spacer()
                     if let location = currentLocation {
                         Text("\(Int(location.distance(from: feature.location).metersToMiles())) mi").font(.footnote).foregroundStyle(Color.secondary)
                     }
                     Spacer()
                 }
            }
            Spacer()
            Image(systemName: "chart.xyaxis.line").foregroundColor(feature.magColor)
            Text(String(format:"%.1f", feature.properties.mag)).foregroundStyle(feature.magColor).fontWeight(.semibold)
            Spacer()
        }
    }
}

#Preview {
    FeatureListItemView(Feature.mockFeature, currentLocation: CLLocation(latitude: 37.00, longitude: -127.00))
}
