import Foundation

struct FrenchArticle: Identifiable, Codable {
    let id = UUID()
    let title: String
    let content: String
    let vocabulary: [String: String] // French word -> English translation
    let difficulty: String = "A2"
    
    init(title: String, content: String, vocabulary: [String: String]) {
        self.title = title
        self.content = content
        self.vocabulary = vocabulary
    }
} 