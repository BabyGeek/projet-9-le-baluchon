//
//  TranslationData.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 22/07/2022.
//

import Foundation

struct TranslationData: Codable, Hashable {
    let data: TranslationDictionnary
}

struct TranslationDictionnary: Codable, Hashable {
    let translations: [Translation]

    func getText() -> String {
        let texts = translations.map { $0.translatedText }
        return texts.joined(separator: " ")
    }
}

struct Translation: Codable, Identifiable, Hashable {
    let id: UUID
    let translatedText: String

    private enum CodingKeys: String, CodingKey {
        case id, translatedText
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        translatedText = try container.decode(String.self, forKey: .translatedText)
    }
}
