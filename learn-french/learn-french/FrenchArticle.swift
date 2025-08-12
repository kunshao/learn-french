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
    let timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case vocabularyNotes = "vocabulary_notes"
        case timestamp
    }
    
    var formattedDate: String {
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .short
        return displayFormatter.string(from: timestamp)
    }
} 