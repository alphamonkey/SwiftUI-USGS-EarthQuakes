//
//  USGSClient.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import Foundation
enum USGSClientError:Error {
    case invalidURL
    case invalidServerResponse
    case invalidObject
}
struct USGSClient {
    func fetchObject<T:Codable>() async throws -> T {
        
        guard let url = URL(string:"https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02") else {
            throw USGSClientError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                throw USGSClientError.invalidServerResponse
        }
        print(T.self)
        let decoder = JSONDecoder()

        guard let ret = try? decoder.decode(T.self, from: data) else {
            throw USGSClientError.invalidObject
        }
        
        return ret
        
    }
}
