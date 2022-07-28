//
//  Weather.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import Foundation

/// Weather model
struct Weather: Codable, Hashable {
    let name: String
    let sys: WheatherSys
    let main: WeatherMain
    let weather: [WeatherType]
}
