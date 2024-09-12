//
//  ContentView.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel:FeatureListViewModel = FeatureListViewModel()
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
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
                        NavigationLink(value:feature) {
                            FeatureListItemView(feature, currentLocation: viewModel.location)
                        }
                    }.refreshable {
                        Task {
                            await viewModel.doFetch()
                        }
                    }.navigationDestination(for: Feature.self) {
                        feature in
                        FeatureDetailView(feature)
                    }
                }
            }.onAppear {
                viewModel.isShowingDetail = false
                if(viewModel.location == nil) {
                    viewModel.locationManagerDidFailToGetPermissions()
                }
            }.onDisappear {
                viewModel.isShowingDetail = true
                print(navPath.count)
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
            
        }.onOpenURL { url in
            viewModel.isShowingDetail = false
            
            if !navPath.isEmpty {
                navPath.removeLast()
            }
            if let selectedFeature = viewModel.featureCollection?.features.filter({$0.url == url}).first {
                navPath.append(selectedFeature)
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
