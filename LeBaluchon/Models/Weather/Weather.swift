//
//  Weather.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import Foundation
import SwiftUI

/// Weather model
struct Weather: Codable, Hashable {
    let name: String
    let sys: WheatherSys
    let main: WeatherMain
    let weather: [WeatherType]
}

/// Weather type model, contains the weather icon
struct WeatherType: Codable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String

    var symbol: Image {
        switch self.id {
        case 200...232:
            return Image(systemName: "cloud.bolt")
        case 300...321:
            return Image(systemName: "cloud.drizzle")
        case 500...531:
            return Image(systemName: "cloud.rain")
        case 600...622:
            return Image(systemName: "cloud.snow")
        case 700...781:
            return Image(systemName: "cloud.fog")
        case 800:
            return Image(systemName: "sun.max")
        case 802:
            return Image(systemName: "cloud")
        default:
            return Image(systemName: "cloud.sun")
        }
    }
}

/// Weather system model
struct WheatherSys: Codable, Hashable {
    let country: String
    let sunrise: Double
    let sunset: Double
}

/// Weather main model
struct WeatherMain: Codable, Hashable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp
        case pressure
        case humidity
    }

    func getTemp(type: CodingKeys = .temp) -> String {
        var value: Double = 0

        if type == .temp {
            value = temp
        } else if type == .tempMax {
            value = tempMax
        } else if type == .tempMin {
            value = tempMin
        }

        let measurement = Measurement(value: value, unit: UnitTemperature.celsius)
        return MeasurementFormatter().string(from: measurement)
    }
}
