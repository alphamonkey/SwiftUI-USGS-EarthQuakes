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
    case invalidServerResponse(String?)
    case httpError(Int, String?)
    case invalidObject(String?)
}
struct USGSClient {
    func fetchObject<T:Codable>(_ location:CLLocation) async throws -> T {
    
        var urlString = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
        
        let now = Date().ISO8601Format()
        let ago = Date(timeIntervalSinceNow: -(60 * 60 * 24 * Settings.daysAgo.get())).ISO8601Format()
        
        urlString.append("&latitude=\(location.coordinate.latitude)")
        urlString.append("&longitude=\(location.coordinate.longitude)")
        urlString.append("&maxradiuskm=\(Settings.maxRadius.get().milesToKilometers())")
        urlString.append("&minmagnitude=\(Settings.minMag.get())")
        urlString.append("&orderby=magnitude")
        urlString.append("&starttime=\(ago)")
        urlString.append("&endtime=\(now)")
        print(urlString)
        
        guard let url = URL(string:urlString) else {
            throw USGSClientError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from:url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
                throw USGSClientError.invalidServerResponse(String(data:data, encoding: .utf8))
        }
        
        if httpResponse.statusCode != 200 {
            throw USGSClientError.httpError(httpResponse.statusCode, String(data:data, encoding: .utf8))
        }

        let decoder = JSONDecoder()

        guard let ret = try? decoder.decode(T.self, from: data) else {
            // If we get a huge but erroneous body back and throw it in the exception, it causes crazy behavior, so we are truncating it to 4k
            throw USGSClientError.invalidObject(String((String(data:data, encoding: .utf8) ?? "Malformed JSON").prefix(4096)))
        }
        
        return ret
        
    }
}
