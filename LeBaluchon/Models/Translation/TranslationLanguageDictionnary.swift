//
//  TranslationLanguageDictionnary.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 21/07/2022.
//

import Foundation

struct TranslationLanguageDictionnary: Codable, Hashable {
    let languages: [TranslationLanguage]

    func getNameForLanguage(_ language: String) -> String {
        if let language = languages.first(where: { $0.language == language }) {
            return language.name.isEmpty ? language.language : language.name
        }

        return ""
    }
}
