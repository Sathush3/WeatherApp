//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Sathurshan Ramachandran on 2022-05-27.
//

import SwiftUI

struct CurrentWeatherView: View {

    var weatherManager = WeatherManager()
    @State var weather:WeatherBody?
    
    var body: some View {
        VStack{
            // decoding the data from response into weather struct
            if let weatherforecast = weather{
                ZStack(alignment: .leading){
                    // top half
                    VStack{
                        VStack(alignment: .leading, spacing: 5){
                            Text(weatherforecast.name)
                                .bold()
                                .font(.title)
                            
                            Text("Today,\(Date().formatted(.dateTime.month().day().hour().minute()))")
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        VStack{
                            HStack{
                                VStack(spacing:20){
                                    Image(systemName: "\(weatherforecast.weather[0].conditionIcon)")
                                        .font(.system(size: 40))
                                   
                                    Text("\(weatherforecast.weather[0].main)")
                                    
                                }
                                .frame(width:  150,alignment: .leading)
                                
                                Spacer()
                                
                                
                                Text(weatherforecast.main.temp.roundDouble()+"°")
                                    .font(.system(size: 70))
                                    .fontWeight(.bold)
                                    .padding()
                            }
                            .padding()
                            
                            Spacer()
                                .frame(height: 50)
                            // fetching images from internet
                            AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                                                   image
                                                       .resizable()
                                                       .aspectRatio(contentMode: .fit)
                                                       .frame(width: 350)
                                               } placeholder: {
                                                   ProgressView()
                                               }
                                               
                                               Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    // bottom half
                    VStack{
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Weather Now")
                                .bold()
                                .padding(.bottom)
                            HStack{
                                WeatherRowView(logo: "thermometer", name: "Min temp", value: (weatherforecast.main.temp_min.roundDouble()+"°"))
                                Spacer()
                                WeatherRowView(logo: "thermometer", name: "Feels like", value: (weatherforecast.main.feels_like.roundDouble()+"°"))
                            }
                            HStack{
                                WeatherRowView(logo: "wind", name: "Wind Speed", value: String(weatherforecast.wind.speed.roundDouble())+" m/s")
                                Spacer()
                                WeatherRowView(logo: "humidity", name: "Humidity", value: (weatherforecast.main.humidity.roundDouble()+"%"))
                            }
                             
                        }.frame(maxWidth:.infinity,alignment: .leading)
                            .padding()
                            .padding(.bottom,20)
                            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                            .background(.white)
                            .cornerRadius(20,corners: [.topLeft,.topRight ])
                    
                    }
                }
               // .edgesIgnoringSafeArea(.bottom)
                .background(Color(hue: 0.754, saturation: 0.462, brightness: 0.806))
                .preferredColorScheme(.dark) // MARK: System wide Dark mode
                
            }else{
                // when the api request takes time a loading icon is displayed
                LoadingView()
                    .task {
                        do{
                            // api call request
                           weather = try await weatherManager.getCurrentWeather()
                        }catch{
                            print("Error getting weather: \(error )")
                        }
                    }
            }
        }
    }
}


struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
    }
}

