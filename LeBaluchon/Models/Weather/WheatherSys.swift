//
//  WheatherSys.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 28/07/2022.
//

import Foundation

/// Weather system model
struct WheatherSys: Codable, Hashable {
    let country: String
    let sunrise: Double
    let sunset: Double
}
