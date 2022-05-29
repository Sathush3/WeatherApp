//
//  Double+Extensions.swift
//  OpenWeatherMapApp
//
//  Created by Sathurshan Ramachandran on 2022-05-27.
//

import Foundation

// MARK: Double Extensions
extension Double {
    /// Fixes double values to a provided number of decimal places
    /// - Parameter places: Number of decimal places
    /// - Returns: Double fixed to a certain number of decimal places
    func fixedTo(_ places: Int) -> Double {
        let divisor: Double = pow(10, Double(places))
        return (divisor * self).rounded() / divisor
    }
    
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
