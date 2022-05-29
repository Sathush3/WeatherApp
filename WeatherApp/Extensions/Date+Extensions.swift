//
//  Date+Extensions.swift
//  OpenWeatherMapApp
//
//  Created by Sathurshan Ramachandran on 2022-05-27.
//

import Foundation

//Extension to format date
extension Date {
    func get(_ type: Calendar.Component)-> Int {
        let calendar = Calendar.current
        let t = calendar.component(type, from: self)
        return Int(t < 10 ? "0\(t)" : t.description) ?? 0
    }
}
