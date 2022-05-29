//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Sathurshan Ramachandran on 2022-05-27.
//

import Foundation


class WeatherManager{
   
    // colombo latitude and longitude
    private let latituteCMB = 6.9319
    private let longitudeCMB = 79.8478
    
    //@Published var weather: WeatherModel?
    private var unit: WeatherUnit = .metric

    //
    let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(API.key)"
    let oneCallBaseURL: String = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely&appid=\(API.key)"
    
    func getCurrentWeather()async throws -> WeatherBody{
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latituteCMB)&lon=\(longitudeCMB)&appid=\(API.key)&units=metric")else {
            fatalError("Missing URL ")
        }
        
        let  urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching weather Data")}
        
        let decodedData = try JSONDecoder().decode(WeatherBody.self, from:data)

        return decodedData
        
        
    }
    
    
    
    func getWeatherForCity(city: String , unit:WeatherUnit) async throws -> WeatherBody{
        self.unit = unit
        guard let url = URL(string: "\(currentWeatherURL)&q=\(city)&units=\(unit.rawValue)" ) else{
            fatalError("Missing URL for City")
        }
        
        let  urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching weather Data")}
        
        let decodedData = try JSONDecoder().decode(WeatherBody.self, from:data)

        return decodedData
        
    }
    
    
    
    
    func getForecastDays(unit:WeatherUnit)async throws -> DailyForecast{
        
       
        guard let url = URL(string: "\(oneCallBaseURL)&lat=\(latituteCMB)&lon=\(longitudeCMB)&units=\(unit.rawValue)")else {
            fatalError("Missing URL ")
        }
        
        let  urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching weather Data")}
        
        let decodedData = try JSONDecoder().decode(DailyForecast.self, from:data)
        
        
        return decodedData
        
        
    }
    
    func getForecastHourly(unit:WeatherUnit)async throws -> HourlyForecast{
        
       
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latituteCMB)&lon=\(longitudeCMB)&units=\(unit.rawValue)&appid=\(API.key)")else {
            fatalError("Missing URL ")
        }
        
        let  urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching weather Data")}
        
        let decodedData = try JSONDecoder().decode(HourlyForecast.self, from:data)
        
        
        return decodedData
        
        
    }
    
    
}
