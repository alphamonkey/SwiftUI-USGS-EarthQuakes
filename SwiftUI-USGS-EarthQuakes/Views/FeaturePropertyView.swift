//
//  FeaturePropertyView.swift
//  SwiftUI-USGS-EarthQuakes
//
//  Created by Josh Edson on 8/19/24.
//

import SwiftUI

struct FeaturePropertyView: View {
    let propertyKey:String
    let propertyValue:Any?
    
    init(propertyKey: String, propertyValue: Any?) {
        self.propertyKey = propertyKey
        self.propertyValue = propertyValue
    }
    
    var body: some View {
        HStack {
            Text("\(propertyKey): ").fontWeight(.bold).padding(.leading, 4.0)
            if let pVal = propertyValue {
                Text("\(pVal)")
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
