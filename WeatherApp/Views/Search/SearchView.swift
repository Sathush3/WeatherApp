//
//  SearchView.swift
//  WeatherApp
//
//  Created by Sathurshan Ramachandran on 2022-05-27.
//

import SwiftUI

struct SearchView: View {
    @State private var city:String = ""
    @State private var unit:Bool = false // toggle for unit change
    @State var weatherManager = WeatherManager()
    @State var weather:WeatherBody?
    @State private var showingAlert = false // alert trigger for wrong inputs
    var body: some View {
        VStack{
            HStack{
                TextField("Enter a city ", text: $city)
                    .padding()
                    .font(.title2)
                    .textFieldStyle(.roundedBorder)
                    
                    
                Button {
                    Task{
                    do{
                        // api call to get details
                        weather = try await weatherManager.getWeatherForCity(city: self.city, unit: unit ? .imperial : .metric)
                    }catch{
                        print("Error getting weather: \(error )")
                    }
                    }
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .font(.largeTitle)
                        
                }
                

            }
            Toggle(isOn: $unit) {
                
                Text("Is Imperial ?")
                    .font(.title3)
            }.padding()
            
                .alert("Non Existent Location \nKindly Re-check the Spelling ", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                            // when receiving the msg from "outside"
                            .onReceive(NotificationCenter.default.publisher(for: WeatherManager.showAlertMsg)) { msg in
                                self.showingAlert = true // simply change the state of the View
                            }
            // passing into row view for customization
            if let weatherForCity = weather{
                SearchRowView(iconName: "thermometer", title: "Temperature", colour: .red, value: weatherForCity.main.temp, unitSymbol: unit ? "° F" : "° C")
                
                SearchRowView(iconName: "drop.fill", title: "Humidity", colour: .blue, value: weatherForCity.main.humidity, unitSymbol: "%")
                
                SearchRowView(iconName: "speedometer", title: "Pressure", colour: .green, value: weatherForCity.main.pressure, unitSymbol: " hPA")
                
                SearchRowView(iconName: "cloud", title: "Cloud Percentage", colour: .gray, value: Double(weatherForCity.clouds.all), unitSymbol: " %")
                
                SearchRowView(iconName: "wind", title: "Wind Speed", colour: .yellow, value: weatherForCity.wind.speed, unitSymbol: unit ? " mph" : " m/s")
                
                SearchRowView(iconName: "location.circle", title: "Wind Direction", colour: .red, value: weatherForCity.wind.deg, unitSymbol: "°")
            

                Spacer()
                
                
            }else{
                Spacer()
            }
            
        }//updating the list when toggle ic used to change
        .onChange(of: unit) { newValue in
            Task{
            do{
                weather = try await weatherManager.getWeatherForCity(city: self.city, unit: unit ? .imperial : .metric)
            }catch{
                print("Error getting weather: \(error )")
            }
            }
        }
       // .preferredColorScheme(.light) // MARK: System wide light mode
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


