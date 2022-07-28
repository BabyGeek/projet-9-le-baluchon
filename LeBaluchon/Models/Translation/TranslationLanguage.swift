//
//  TranslationLanguage.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 28/07/2022.
//

import Foundation

struct TranslationLanguage: Codable, Identifiable, Hashable {
    let id: UUID
    let language: String
    let name: String

    private enum CodingKeys: String, CodingKey {
      case id, language, name
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        language = try values.decode(String.self, forKey: .language)
        name = try values.decode(String.self, forKey: .name)
    }
}
