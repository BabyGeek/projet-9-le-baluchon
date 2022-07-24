//
//  CurrencySymbol.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import Foundation

/// Currency dictionnary model
struct CurrencyDictionnary: Codable, Hashable {
    let result: String
    let supported_codes: [[String]]
    var currencies: [CurrencySymbol] = [CurrencySymbol]()

    /// Extract currencies array of CurrencySymbol from decoder supported codes found, and sort the currencies
    /// - Parameter decoder: Decoded datas to work with
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decode(String.self, forKey: .result)
        supported_codes = try values.decode([[String]].self, forKey: .supported_codes)

        for symbol in self.supported_codes {
            self.currencies.append(CurrencySymbol(code: symbol[0], name: symbol[1]))
        }

        self.currencies.sort {
            $0.code < $1.code
        }
    }
}
