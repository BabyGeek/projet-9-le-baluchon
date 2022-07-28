//
//  WeatherMain.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 28/07/2022.
//

import Foundation

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
        dump(measurement)
        return MeasurementFormatter().string(from: measurement)
    }
}
