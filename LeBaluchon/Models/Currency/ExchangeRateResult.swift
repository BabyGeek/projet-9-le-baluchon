//
//  CurrencyResult.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import Foundation

struct ExchangeRateResult: Codable, Hashable {
    let success: Bool
    let query: ExchangeRateQuery
    let info: ExchangeRateInfo
    let result: Double
}

struct ExchangeRateQuery: Codable, Hashable {
    let from: String
    let to: String
    let amount: Double
}

struct ExchangeRateInfo: Codable, Hashable {
    let timestamp: Int
    let rate: Double
}
