//
//  ContentView.swift
//  WeatherApp
//
//  Created by Sathurshan Ramachandran on 2022-05-27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            
            CurrentWeatherView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                        .labelStyle(.iconOnly)
                }
            SearchView()
                .tabItem{
                    Label("Search", systemImage: "magnifyingglass")
                        .labelStyle(.iconOnly)
                       
                }
            ForecastView()
                .tabItem{
                    Label("Forecast", systemImage: "cloud.drizzle")
                        .labelStyle(.iconOnly)
                        
                }
            ForecastHourlyView()
                .tabItem{
                    Label("Hourly", systemImage: "hourglass")
                        .labelStyle(.iconOnly)
                    
                }
        }.preferredColorScheme(.dark) // MARK: System wide Dark mode
            .accentColor(.yellow)
        //.padding(.top)
        //
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
