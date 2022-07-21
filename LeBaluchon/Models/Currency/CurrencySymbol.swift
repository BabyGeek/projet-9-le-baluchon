//
//  CurrencySymbol.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import Foundation

struct CurrencySymbol: Codable, Hashable {
    var code: String
    let name: String
}

extension CurrencySymbol {
    public func getSymbol() -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
}
