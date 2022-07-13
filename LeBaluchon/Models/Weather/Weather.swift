//
//  Weather.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import Foundation

struct Weather: Codable, Hashable {
    let name: String
    let sys: WheatherSys
    let main: WheatherMain
    let weather: [WeatherType]
}

struct WeatherType: Codable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WheatherSys: Codable, Hashable {
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct WheatherMain: Codable, Hashable  {
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
}
