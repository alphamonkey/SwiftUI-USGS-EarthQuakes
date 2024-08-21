//
//  FeaturePropertyView.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/19/24.
//

import SwiftUI

struct FeaturePropertyView: View {
    enum PropertyViewType {
        case text
        case progress
    }
    
    let propertyKey:String
    let propertyValue:Any?
    let type:PropertyViewType
    init(propertyKey: String, propertyValue: Any?) {
        self.propertyKey = propertyKey
        self.propertyValue = propertyValue
        self.type = .text
    }
    init(propertyKey: String, propertyValue: Any?, type:PropertyViewType) {
        self.propertyKey = propertyKey
        self.propertyValue = propertyValue
        self.type = type
    }
    var body: some View {
        HStack {
            Text("\(propertyKey): ").fontWeight(.bold).padding(.leading, 4.0)
            if let pVal = propertyValue {
                switch type {
                case .text:
                    Text("\(pVal)")
                case .progress:
                    if let value = pVal as? Double {
                        ProgressView(value:value)
                    }
                }
                
            }
            else {
                Text("null").foregroundStyle(Color.secondary).italic()
            }
            Spacer()
        }
    }
}

#Preview {
    FeaturePropertyView(propertyKey:"Test", propertyValue:"Test")
}
