//
//  SettingsView.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/20/24.
//

import SwiftUI

struct SettingsView: View {
    let delegate:SettingsViewDelegate?
    @State var viewModel:SettingsViewModel = SettingsViewModel()
    @Binding var isPresented:Bool
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack() {
                Button("", systemImage: "xmark.square.fill") {
                    isPresented = false
                }.foregroundStyle(Color.highMag).padding(16)
                
                Text("Settings").font(.title2)
            }
            
            VStack {
                FeaturePropertyView(propertyKey: "Max Radius (miles)", propertyValue: Int(viewModel.radiusSliderValue))
                Slider(value:$viewModel.radiusSliderValue, in:1...500, step:1) { editing in
                    if(!editing) {
                        viewModel.maxRadius = viewModel.radiusSliderValue
                        delegate?.didUpdateSettings()
                    }
                }
                FeaturePropertyView(propertyKey: "Minimum Magnitude", propertyValue: String(format:"%.1f", viewModel.minMagSliderValue))
                Slider(value:$viewModel.minMagSliderValue, in:0...10, step:0.1) { editing in
                    if(!editing) {
                        viewModel.minMag = viewModel.minMagSliderValue
                        delegate?.didUpdateSettings()
                    }
                }
                FeaturePropertyView(propertyKey: "Date (days ago)", propertyValue: Int(viewModel.daysAgoSliderValue))
                Slider(value:$viewModel.daysAgoSliderValue, in:1...365, step:1) { editing in
                    if(!editing) {
                        viewModel.daysAgo = viewModel.daysAgoSliderValue
                        delegate?.didUpdateSettings()
                    }
                }
            }.padding(16)
            Spacer()
        }
    }
}
protocol SettingsViewDelegate {
    func didUpdateSettings()
}


