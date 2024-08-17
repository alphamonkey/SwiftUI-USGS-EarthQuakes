//
//  USGSClient.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import Foundation
import CoreLocation

enum USGSClientError:Error {
    case invalidURL
    case invalidServerResponse
    case invalidObject
}
struct USGSClient {
    func fetchObject<T:Codable>(_ location:CLLocation) async throws -> T {
    
        var urlString = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
        
        let now = Date().ISO8601Format()
        let ago = Date(timeIntervalSinceNow: -(60 * 60 * 24)).ISO8601Format()
        
        urlString.append("&latitude=\(location.coordinate.latitude)")
        urlString.append("&longitude=\(location.coordinate.longitude)")
        urlString.append("&maxradiuskm=80")
        urlString.append("&minmagnitude=1")
        urlString.append("&orderby=magnitude")
        urlString.append("&starttime=\(ago)")
        urlString.append("&endtime=\(now)")
        
        guard let url = URL(string:urlString) else {
            throw USGSClientError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                throw USGSClientError.invalidServerResponse
        }

        let decoder = JSONDecoder()

        guard let ret = try? decoder.decode(T.self, from: data) else {
            throw USGSClientError.invalidObject
        }
        
        return ret
        
    }
}
