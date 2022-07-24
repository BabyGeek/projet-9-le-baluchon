//
//  CurrencySymbol.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import Foundation

/// Currency symbol model
struct CurrencySymbol: Codable, Hashable {
    var code: String
    let name: String
}

extension CurrencySymbol {
    /// Currency more human friendly symbol
    /// - Returns: The string symbol if found
    public func getSymbol() -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
}

enum CurrencyType {
    case source, target
}
