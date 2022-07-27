//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Sathurshan Ramachandran on 2022-05-27.
//

import SwiftUI

struct ForecastView: View {
    var weatherManager = WeatherManager()
    //@State private var unit:Bool = false
    @State private var unit: WeatherUnit = .metric
    @State var weather:DailyForecast?
    var body: some View {
        NavigationView {
            VStack{ // picker for metric and imperial units
                Picker("", selection: $unit) {
                Text("° C")
                    .tag(WeatherUnit.metric)
                Text("° F")
                    .tag(WeatherUnit.imperial)
            }
            .pickerStyle(.segmented)
            .padding()
            .frame(width:150)
                HStack() {
                    Text("Colombo")
                        .font(.headline)
                    Spacer()
                }.padding(.leading)
                // list to display the day forecast and seperated by date section
                if let weatherForecast = weather{
                    List(0..<6){ index in
                        let item = weatherForecast.daily[index]
                        Section(item.dt.unixToDate()!) {
                            HStack(spacing: 20) {
                                // main icon
                                Image(systemName: item.weather.first!.conditionIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.cyan, .orange)
                                    .padding(.trailing,5)
                                //information display
                                VStack (alignment: .leading) {
                                    Text(item.weather.first!.description)
                                    // temperature
                                    HStack()  {
                                        Text("High:")
                                        Text("\(item.temp.max.roundDouble())"+"\(unit == .metric ? "° C" : "° F")")
                                        Spacer()
                                            .frame(width:10)
                                        Text("Low:")
                                        Text("\(item.temp.min.roundDouble())"+"\(unit == .metric ? "° C" : "° F")")
                                    }
                                    // for cloud and wind speed
                                    HStack(spacing:20) {
                                        Image(systemName: "cloud")
                                            .foregroundColor(.gray)
                                        Text("\(item.clouds)%")
                                        Image(systemName: "wind")
                                            .foregroundColor(.green)
                                        Text("\(item.wind_speed.roundDouble())"+"\(unit == .metric ? " m/s": " mph") ")
                                       
                                    } // humidity
                                    HStack(spacing:25) {
                                        Image(systemName: "drop")
                                            .foregroundColor(.blue)
                                        Text("\(item.humidity)%")
                                    }.padding(.leading,5)
                                    
                                    
                                    
                                }
                            }
                        }
                        
                        
                    }.listStyle(PlainListStyle())
                    .onChange(of: unit) { newValue in
                        Task{ //when picker is used to change the unit request is made
                            do{
                                weather = try await weatherManager.getForecastDays(unit: self.unit)
                            }catch{
                                print("Error getting weather: \(error )")
                            }
                            
                        }
                    }
                    
                    
                    
                } else{
                    // display loading icon and view when the api request takes long
                    LoadingView()
                        .task {
                            do{
                                weather = try await weatherManager.getForecastDays(unit: self.unit)
                            }catch{
                                print("Error getting weather: \(error )")
                            }
                        }
                }
                
            } //.preferredColorScheme(.light) // MARK: System wide light mode
            .navigationTitle("Mobile Weather")
            .font(.title2)
           
        }
           
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
