//
//  LocationManager.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/17/24.
//

import SwiftUI
import CoreLocation

@Observable class LocationManager: NSObject {
    
    let manager = CLLocationManager()
    var location:CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    
    
}

extension LocationManager:CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("-- Did Change Authorization --")
        if manager.authorizationStatus != .denied {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("-- Did Update Location --")
        self.location = locations[0]
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("-- Did Fail with error --")
        print("-- \(error.localizedDescription) --")
    }
}

