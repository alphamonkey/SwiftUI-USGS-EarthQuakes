//
//  LocationManager.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/17/24.
//

import SwiftUI
import CoreLocation

@Observable class LocationManager: NSObject {
    
    var location:CLLocation?
    
    private let manager = CLLocationManager()
    var delegate:LocationManagerUpdateDelegate?
    
    convenience init(delegate:LocationManagerUpdateDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        
    }

}
protocol LocationManagerUpdateDelegate {
    func locationManagerDidDoInitialUpdate()
    func locationManagerDidFailToGetPermissions()
}

extension LocationManager:CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("-- Did Change Authorization --")
        
        if manager.authorizationStatus != .denied {
            manager.startUpdatingLocation()
        }
        else {
            delegate?.locationManagerDidFailToGetPermissions()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("-- Did Update Location --")
        var shouldDoInitialUpdate = false
        if (location == nil) {
            shouldDoInitialUpdate = true
            manager.desiredAccuracy = kCLLocationAccuracyReduced
            manager.distanceFilter = 100
        }
        self.location = locations[0]
        if(shouldDoInitialUpdate && self.delegate != nil) {
            self.delegate?.locationManagerDidDoInitialUpdate()

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("-- Did Fail with error --")
        print("-- \(error.localizedDescription) --")
        delegate?.locationManagerDidFailToGetPermissions()
        
    }
}

