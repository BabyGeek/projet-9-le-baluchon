//
//  TranslationLanguageDictionnary.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 21/07/2022.
//

import Foundation

struct TranslationLanguageData: Codable, Hashable {
    let data: TranslationLanguageDictionnary
}

struct TranslationLanguageDictionnary: Codable, Hashable {
    let languages: [TranslationLanguage]
}

struct TranslationLanguage: Codable, Identifiable, Hashable {
    let id: UUID
    let language: String
    let name: String
    
    
    private enum CodingKeys: String, CodingKey {
      case id, language, name
    }
      
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        language = try container.decode(String.self, forKey: .language)
        name = try container.decode(String.self, forKey: .name)
    }
}
