//
//  CurrencyResult.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import Foundation

/// Currency exchange rate model
struct ExchangeRateResult: Codable, Hashable {
    let success: String
    let from: String
    let to: String
    let result: Double
    let rate: Double
    
    
    enum CodingKeys: String, CodingKey {
        case success = "result"
        case from = "base_code"
        case to = "target_code"
        case result = "conversion_result"
        case rate = "conversion_rate"
    }
}
