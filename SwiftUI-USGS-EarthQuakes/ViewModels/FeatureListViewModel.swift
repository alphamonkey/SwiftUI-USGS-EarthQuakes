//
//  FeatureListViewModel.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 9/5/24.
//

import SwiftUI
import CoreLocation
@Observable class FeatureListViewModel {
    
    var featureCollection:FeatureCollection?
    var isLoading:Bool = false;
    var lastUpdateDate:Date?
    
    private var locationManager = LocationManager()
    private var client = USGSClient()
    
    var isShowingError = false
    var errorMessage:String?
    var errorTitle = "Error"
    
    var isShowingDetail = false
    var isShowingSettings = false
    var location:CLLocation? {
        return locationManager.location
    }
    init() {
        self.locationManager.delegate = self

    }
    
    func doFetch() async {
        guard let location = locationManager.location else {return}
        isShowingError = false
        isLoading = true
        do {
            featureCollection = try await client.fetchObject(location)
            lastUpdateDate = Date()
        } catch USGSClientError.httpError(let code, let message) {
            isShowingError = true
            errorMessage = message
            errorTitle = "HTTP Error \(code)"
        } catch USGSClientError.invalidURL {
            isShowingError = true
            errorTitle = "Invalid URL"
        } catch USGSClientError.invalidObject(let response) {
            isShowingError = true
            errorTitle = "Invalid JSON Object"
            errorMessage = response
        } catch USGSClientError.invalidServerResponse(let response) {
            isShowingError = true
            errorTitle = "Invalid Server Response"
            errorMessage = response
        } catch {
            isShowingError = true
            errorTitle = "Unexpected error"
            errorMessage = "\(error.localizedDescription)"
        }

        isLoading = false
        
    }
}

extension FeatureListViewModel:LocationManagerUpdateDelegate {
    func locationManagerDidDoInitialUpdate() {
        Task {
            await doFetch()
        }
    }
    func locationManagerDidFailToGetPermissions() {
        isShowingError=true
        isLoading=false
        
        errorTitle = "Location Services"
        errorMessage = "Could not find your location.  Please make sure you have granted permission for this app in Settings."
    }
}
