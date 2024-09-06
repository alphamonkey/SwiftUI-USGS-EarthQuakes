//
//  ContentView.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel:FeatureListViewModel = FeatureListViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {

                if(viewModel.isLoading) {
                    ProgressView().controlSize(.extraLarge).tint(.accentColor)
                }

                else if(viewModel.isShowingError) {
                    Text(viewModel.errorTitle).font(.title).foregroundStyle(Color.highMag)
                    Text(viewModel.errorMessage ?? "").padding(16).border(.secondary).padding([.leading, .trailing], 24)
                }
                
                else if let fc = viewModel.featureCollection {
                    List(fc.features, id: \.self) { feature in
                        NavigationLink(destination: FeatureDetailView(feature)) {
                            FeatureListItemView(feature, currentLocation: viewModel.location)
                        }
                    }.refreshable {
                        Task {
                            await viewModel.doFetch()
                        }
                    }
                }
            }.onAppear {
                viewModel.isShowingDetail = false
                if(viewModel.location == nil) {
                    viewModel.locationManagerDidFailToGetPermissions()
                }
            }.onDisappear {
                viewModel.isShowingDetail = true
            }

        }
        
        .navigationTitle("Test").toolbar {
            if(viewModel.isShowingDetail == false) {
                ToolbarItem(placement:.bottomBar) {
                    Button("", systemImage:"gearshape") {
                        viewModel.isShowingSettings.toggle()
                    }.sheet(isPresented: $viewModel.isShowingSettings, content: {
                        SettingsView(delegate:self, isPresented:$viewModel.isShowingSettings)
                    })
                     
                }
                ToolbarItem(placement:.bottomBar){
                    Spacer()
                }
                ToolbarItem(placement:.bottomBar){
                    VStack {
                        if let fc = viewModel.featureCollection {
                            Text("\(fc.metadata.count) Earthquakes")
                        }
                        Text("Last updated: \(viewModel.lastUpdateDate == nil ? "Never" : UtilityFunctions.defaultDateFormatter().string(from:viewModel.lastUpdateDate!))").font(.footnote).foregroundStyle(Color.secondary)
                    }
                }
                ToolbarItem(placement:.bottomBar){
                    Spacer()
                }
                ToolbarItem(placement:.bottomBar){
                    Button("", systemImage:"arrow.circlepath") {
                        Task {
                            await viewModel.doFetch()
                        }
                    }

                }

            }
            
        }
      
    }
}


extension ContentView:SettingsViewDelegate {
    func didUpdateSettings() {
        Task {
            await viewModel.doFetch()
        }
    }
}
#Preview {
    ContentView()
}
