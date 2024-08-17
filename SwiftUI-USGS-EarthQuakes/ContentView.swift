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
    @State private var isShowingError = false
    @State private var errorMessage:String?
    @State private var errorTitle = "Error"

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
                        await doFetch()
                    }
                    

                    
                }

            }

        }.alert(isPresented:$isShowingError) {
            Alert(title: Text(errorTitle), message: Text(errorMessage ?? ""), dismissButton: .default(Text("Ok")))
        }
      
    }
}
extension ContentView {
    func doFetch() async {
        guard let location = locationManager.location else {return}
        
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
#Preview {
    ContentView()
}
