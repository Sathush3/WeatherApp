//
//  ForecastHourlyView.swift
//  WeatherApp
//
//  Created by Sathurshan Ramachandran on 2022-05-27.
//

import SwiftUI

struct ForecastHourlyView: View {
   @State var weatherManager = WeatherManager()
    @State var weather:DailyForecast?
    var unit:WeatherUnit = .metric
    @State var hourlyWeather:HourlyForecast?
    
    
    var body: some View {
        
        VStack{
            if let weatherForecast = weather {
                VStack(alignment: .center){
                    Text(weatherForecast.current.dt.unixToDate(date: .complete, time: .shortened)!)
                    HStack{
                        Image(systemName: "\(weatherForecast.current.weather[0].conditionIcon)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.gray , .cyan, .orange)

                            
                        Text("\(weatherForecast.current.temp.roundDouble())°")
                            .font(.system(size: 40,design: .monospaced))
                            .padding(.leading)
                    }.padding()
                    Text(weatherForecast.current.weather[0].description)
                }
                }else{
                    LoadingView()
                        .task {
                            do{
                                weather = try await weatherManager.getForecastDays(unit: self.unit)
                            }catch{
                                print("Error getting weather: \(error )")
                            }
                        }
                    
                }
            if let hourlyCast = hourlyWeather{
                List(0..<hourlyCast.list.count){ index in
                    let item = hourlyCast.list[index]
                    HStack{
                        Image(systemName: "\(item.weather.first!.conditionIcon)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.cyan, .orange)
                            .padding(.trailing,5)
                        VStack(alignment: .leading){
                            Text("\(item.weather.first!.description)")
                            Text(item.dt.unixToDate(date: .complete, time: .shortened)!)
                            
                        }
                        Spacer()
                        Text("\(item.main.temp.roundDouble()) °C ")
                            
                        
                    }
                    
                }
            } else{
                LoadingView()
                    .task {
                        do{
                            hourlyWeather = try await weatherManager.getForecastHourly(unit: self.unit)
                        }catch{
                            print("Error getting weather: \(error )")
                        }
                    }
                
            }
                }
            }
       
    }


struct ForecastHourlyView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastHourlyView()
        
    }
}
