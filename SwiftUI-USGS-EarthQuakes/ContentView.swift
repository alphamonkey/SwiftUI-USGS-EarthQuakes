//
//  ContentView.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import SwiftUI

struct ContentView: View {
    

    
    @State private var featureCollection:FeatureCollection?
    @State private var isLoading:Bool = false;
    @State private var lastUpdateDate:Date?
    @State private var locationManager = LocationManager()
    @State private var client = USGSClient()
    
    var body: some View {
        NavigationStack {
            if(isLoading) {
                ProgressView().controlSize(.extraLarge).tint(.accentColor)
            }
            else if let fc = featureCollection {
                List(fc.features, id: \.self) { feature in
                    Text(feature.properties.place)
                }
            }

        }.navigationTitle("Test").toolbar {
            ToolbarItem(placement:.bottomBar){
                Button("", systemImage:"gearshape") {
                    return;
                }

            }
            ToolbarItem(placement:.bottomBar){
                Spacer()
            }
            ToolbarItem(placement:.bottomBar){
                VStack {
                    if let fc = self.featureCollection {
                        Text("\(fc.metadata.count) Earthquakes")
                    }
                    
                    Text("Last updated: \(lastUpdateDate == nil ? "Never" : UtilityFunctions.defaultDateFormatter().string(from:lastUpdateDate!))").font(.footnote)
                }
            }
            ToolbarItem(placement:.bottomBar){
                Spacer()
            }

            ToolbarItem(placement:.bottomBar){
                Button("", systemImage:"arrow.circlepath") {
                    Task {
                        guard let location = locationManager.location else {return}
                        
                        isLoading = true
                        featureCollection = try await client.fetchObject(location)
                        lastUpdateDate = Date()
                        isLoading = false
                        

                    }
                    
                }.disabled(locationManager.location == nil)

            }

        }
      
    }
}

#Preview {
    ContentView()
}
