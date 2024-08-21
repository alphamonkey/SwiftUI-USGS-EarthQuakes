//
//  SettingsView.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/20/24.
//

import SwiftUI

struct SettingsView: View {
    let delegate:SettingsViewDelegate?
    @Binding var isPresented:Bool
    @State var maxRadius:Double = Settings.maxRadius.get()
    @State var minMag:Double = Settings.minMag.get()
    @State var daysAgo:Double = Settings.daysAgo.get()
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack() {
                Button("", systemImage: "xmark.square.fill") {
                    isPresented = false
                }.foregroundStyle(Color.highMag).padding(16)
                
                Text("Settings").font(.title2)
            }
            
            VStack {
                FeaturePropertyView(propertyKey: "Max Radius (miles)", propertyValue: Int(maxRadius))
                Slider(value:$maxRadius, in:1...500, step:1) { editing in
                    if(!editing) {
                        Settings.maxRadius.set(maxRadius)
                        delegate?.didUpdateSettings()
                    }
                }
                FeaturePropertyView(propertyKey: "Minimum Magnitude", propertyValue: String(format:"%.1f", minMag))
                Slider(value:$minMag, in:0...10, step:0.1) { editing in
                    if(!editing) {
                        Settings.minMag.set(minMag)
                        delegate?.didUpdateSettings()
                    }
                }
                FeaturePropertyView(propertyKey: "Date (days ago)", propertyValue: Int(daysAgo))
                Slider(value:$daysAgo, in:1...365, step:1) { editing in
                    if(!editing) {
                        Settings.daysAgo.set(daysAgo)
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


