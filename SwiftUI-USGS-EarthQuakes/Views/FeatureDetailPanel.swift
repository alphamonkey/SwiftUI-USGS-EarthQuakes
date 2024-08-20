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
        

        VStack(alignment: .leading) {
            FeaturePropertyView(propertyKey: "Time", propertyValue: UtilityFunctions.defaultDateString(feature.date))
            FeaturePropertyView(propertyKey: "Magnitude", propertyValue: (feature.properties.mag))
            FeaturePropertyView(propertyKey: "Alert", propertyValue: feature.properties.alert)
            FeaturePropertyView(propertyKey: "Significance", propertyValue: feature.properties.sig)
        }.padding(8)

    }
}


#Preview {
    FeatureDetailPanel(Feature.mockFeature)
}
