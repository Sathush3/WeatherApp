//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by Sathurshan Ramachandran on 2022-05-28.
//

import Foundation


struct DailyForecast: Decodable {
    let current: Current
    let daily: [WeatherDaily]
    let hourly: [WeatherHourly]
    
}

struct Current: Decodable {
    let dt: Int
    let temp: Double
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
    let weather: [WeatherResponse]
}

struct WeatherDaily: Decodable {
    let dt: Int
    let temp: Temperature
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
    let weather: [WeatherResponse]
    
}

struct Temperature: Decodable {
    let day: Double
    let min: Double
    let max: Double
}

struct WeatherHourly: Decodable {
    let dt: Int
    let temp: Double
    let weather: [WeatherResponse]
    //let icon: String
   // let hour: Int
}

