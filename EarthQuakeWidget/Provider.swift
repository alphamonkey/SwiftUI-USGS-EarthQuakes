//
//  Provider.swift
//  EarthQuakeWidgetExtension
//
//  Created by Josh Edson on 9/6/24.
//

import WidgetKit
import CoreLocation
import MapKit

struct Provider: TimelineProvider {
    
    let client = USGSClient()
    let locationManager = LocationManager()

    private func makeSnapshot(entry:FeatureEntry, size:CGSize) -> MKMapSnapshotter {
        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        let region = MKCoordinateRegion(center:entry.feature.location.coordinate, span:span)
        let options = MKMapSnapshotter.Options()
        options.region = region
        options.size = size
        return MKMapSnapshotter(options: options)
    }
    
    func placeholder(in context: Context) -> FeatureEntry {
        print("-- Get placeholder -- ")
        return FeatureEntry(date: Date(), feature: Feature.mockFeature)
    }

    func getSnapshot(in context: Context, completion: @escaping (FeatureEntry) -> ()) {
        print("-- Get Snapshot -- ")
        if let location = locationManager.location {
            Task {
                if let featureCollection:FeatureCollection = try? await client.fetchObject(location) {
                    if featureCollection.metadata.count != 0 {
                        var entry = FeatureEntry(date:Date(), feature: featureCollection.features[0])
                        
                        let mapSnapShotter = makeSnapshot(entry: entry, size: context.displaySize)
                         let snapshot = try await mapSnapShotter.start()
                            entry.image = snapshot.image
                        completion(entry)
                    }

                }
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print("-- Get timeline -- ")
        
        if let location = locationManager.location {
            Task {
                if let featureCollection:FeatureCollection = try? await client.fetchObject(location) {
                    if featureCollection.metadata.count != 0 {
                        var entry = FeatureEntry(date:Date(), feature: featureCollection.features[0])
                        
                        let mapSnapShotter = makeSnapshot(entry: entry, size: context.displaySize)
                         let snapshot = try await mapSnapShotter.start()
                            entry.image = snapshot.image
                            let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(15 * 60)))
                            completion(timeline)
                    }
                }
            }
        }
    }
}


