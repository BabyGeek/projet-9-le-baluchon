//
//  TranslationDictionnary.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 28/07/2022.
//

import Foundation

struct TranslationDictionnary: Codable, Hashable {
    let translations: [Translation]

    func getText() -> String {
        let texts = translations.map { $0.translatedText }
        return texts.joined(separator: " ")
    }
}
