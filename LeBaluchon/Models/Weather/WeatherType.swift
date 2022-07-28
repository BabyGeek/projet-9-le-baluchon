//
//  WeatherType.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 28/07/2022.
//

import Foundation
import SwiftUI

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
