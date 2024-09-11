//
//  EarthQuakeWidgetEntryView.swift
//  EarthQuakeWidgetExtension
//
//  Created by Josh Edson on 9/6/24.
//
import SwiftUI


struct EarthQuakeWidgetEntryView : View {
    var entry: Provider.Entry


    var body: some View {
        ZStack {
            if let image = entry.image {
                Image(uiImage: image)
            }
            Image(systemName: "target").foregroundColor(Color.highMag).frame(width: 12.0, height: 12.0)
            VStack {
                Spacer()
                HStack {
                    Text(entry.feature.shortPlace.split(separator: ",")[0]).padding([.leading, .trailing]).font(.footnote).foregroundStyle(Color.white)
        
                    Image(systemName:"chart.xyaxis.line").bold().foregroundStyle(entry.feature.magColor).font(.subheadline)
                    Text(String(format:("%.1f"), entry.feature.properties.mag)).padding([.trailing]).foregroundStyle(entry.feature.magColor).font(.subheadline).bold()
                    

                    
                }.background(Color(red:0.0, green:0.0, blue:0.0, opacity: 0.8)).cornerRadius(8.0).frame(width:(entry.image?.size.width ?? 100.0)).padding([.leading, .trailing], 14.0)
               
                
               
            }.padding(8.0).widgetURL(entry.feature.url)
            }
    }


    }
