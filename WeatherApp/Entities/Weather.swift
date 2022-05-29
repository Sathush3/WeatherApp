//
//  Weather.swift
//  WeatherApp
//
//  Created by Sathurshan Ramachandran on 2022-05-27.
//

import Foundation



// Model of the response body we get from calling the OpenWeather API for current weather
struct WeatherBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var clouds: CloudResponse
    
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Int
        var main: String
        var description: String
        var icon: String
        
        var conditionIcon: String {
            switch id {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...802:
                return "cloud.sun"
            case 803...804:
                return "cloud.moon"
            default:
                return "cloud"
            }
        }
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
    
    struct CloudResponse: Decodable {
        let all: Int
    }
    
}


struct WeatherResponse: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    // a sitch case to select icon based on the weather condition codes in OpenweatherMap
    //https://openweathermap.org/weather-conditions
    
    var conditionIcon: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...802:
            return "cloud.sun"
        case 803...804:
            return "cloud.moon"
        default:
            return "cloud"
        }
    }
}
