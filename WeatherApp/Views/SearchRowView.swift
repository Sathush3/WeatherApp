//
//  SearchRowView.swift
//  WeatherApp
//
//  Created by Sathurshan Ramachandran on 2022-05-28.
//

import SwiftUI

struct SearchRowView: View {
    
    var iconName:String
    var title:String
    var colour:Color
    var value:Double
    var unitSymbol:String
    // row view to easier customization
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(colour)
            Text(title)
                .font(.system(size: 16, weight: .regular, design: .rounded))
            Spacer()
            Text(String(value.roundDouble()))
                .font(.system(size: 20, weight: .bold, design: .rounded)) + Text(unitSymbol)
                .font(.system(size: 16, weight: .light, design: .rounded))
        }.padding()
    }
}
struct SearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRowView(iconName: "thermometer", title: "Temperature", colour: .red, value: 37.5, unitSymbol: "°")
    }
}
