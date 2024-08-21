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
    @State private var isShowingDetail = false
    @State private var isShowingSettings = false
    
    var body: some View {
        NavigationStack {
            VStack {

                if(isLoading) {
                    ProgressView().controlSize(.extraLarge).tint(.accentColor)
                }

                else if(isShowingError) {
                    Text(errorTitle).font(.title).foregroundStyle(Color.highMag)
                    Text(errorMessage ?? "").padding(16).border(.secondary).padding([.leading, .trailing], 24)
                }
                
                else if let fc = featureCollection {
                    List(fc.features, id: \.self) { feature in
                        NavigationLink(destination: FeatureDetailView(feature)) {
                            FeatureListItemView(feature, currentLocation: locationManager.location)
                        }
                    }.refreshable {
                        Task {
                            await doFetch()
                        }
                    }
                }
            }.onAppear {
                locationManager.delegate = self
                isShowingDetail = false
                if(locationManager.location == nil) {
                    self.locationManagerDidFailToGetPermissions()
                }
            }.onDisappear {
                isShowingDetail = true
            }

        }
        .navigationTitle("Test").toolbar {
            if(isShowingDetail == false) {
                ToolbarItem(placement:.bottomBar){
                    Button("", systemImage:"gearshape") {
                        isShowingSettings.toggle()
                    }.sheet(isPresented: $isShowingSettings, content: {
                        SettingsView(delegate:self, isPresented:$isShowingSettings)
                    })
                }
                ToolbarItem(placement:.bottomBar){
                    Spacer()
                }
                ToolbarItem(placement:.bottomBar){
                    VStack {
                        if let fc = self.featureCollection {
                            Text("\(fc.metadata.count) Earthquakes")
                        }
                        Text("Last updated: \(lastUpdateDate == nil ? "Never" : UtilityFunctions.defaultDateFormatter().string(from:lastUpdateDate!))").font(.footnote).foregroundStyle(Color.secondary)
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

            }
            
        }
      
    }
}
extension ContentView {
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
extension ContentView:LocationManagerUpdateDelegate {
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

extension ContentView:SettingsViewDelegate {
    func didUpdateSettings() {
        Task {
            await doFetch()
        }
    }
}
#Preview {
    ContentView()
}
