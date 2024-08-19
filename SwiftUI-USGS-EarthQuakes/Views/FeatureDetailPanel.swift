//
//  FeatureDetailPanel.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/19/24.
//

import SwiftUI

struct FeatureDetailPanel: View {
    let feature:Feature
    
    init(_ feature: Feature) {
        self.feature = feature
    }
    var body: some View {
        
        let featureDateString = UtilityFunctions.defaultDateFormatter().string(from: Date(timeIntervalSince1970: feature.properties.time))
        VStack(alignment: .leading) {
            FeaturePropertyView(propertyKey: "Time", propertyValue: featureDateString)
            FeaturePropertyView(propertyKey: "Magnitude", propertyValue: (feature.properties.mag))
            FeaturePropertyView(propertyKey: "Alert", propertyValue: feature.properties.alert)
            FeaturePropertyView(propertyKey: "Significance", propertyValue: feature.properties.sig)
        }.padding(8)

    }
}


