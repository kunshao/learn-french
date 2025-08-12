//
//  FrenchArticle.swift
//  learn-french
//
//  Created by Kun Shao on 1/7/25.
//

import Foundation

struct FrenchArticle: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let vocabularyNotes: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case vocabularyNotes = "vocabulary_notes"
    }
} 