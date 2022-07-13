//
//  Weather.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import Foundation

struct Weather: Hashable, Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Int
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Int
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let weather: [WeatherType]
}

struct WeatherType: Hashable, Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
