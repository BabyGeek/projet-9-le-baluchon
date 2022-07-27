//
//  City.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 26/07/2022.
//

import Foundation

struct City: Codable, Hashable {
    let name: String
    let local_names: [String: String]
    let lat: Double
    let lon: Double
    let country: String
    let state: String

    var description: String {
        return "\(name), \(state), \(country)"
    }
}
