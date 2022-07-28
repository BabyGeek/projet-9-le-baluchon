//
//  Translation.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 28/07/2022.
//

import Foundation

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
