//
//  FeatureDetailView.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/17/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct FeatureDetailView: View {
    
    @State private var feature:Feature
    @State private var position:MapCameraPosition
    
    init(_ feature:Feature){
        self.feature = feature
        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        let region = MKCoordinateRegion(center:feature.location.coordinate, span:span)
        self.position = MapCameraPosition.region(region)
        print(feature.url)
    }
    
    var body: some View {

            VStack {
                Spacer(minLength: 4)
                Map(position: $position) {
                    Marker(feature.properties.place, coordinate:feature.location.coordinate)
                }.cornerRadius(24).padding(8)
                FeatureDetailPanel(feature).background(Color(UIColor.systemGray5)).cornerRadius(24.0).padding([.leading, .trailing], 8)
            }.navigationTitle(feature.properties.place)
    }
}


#Preview {
    FeatureDetailView(Feature.mockFeature)
}
