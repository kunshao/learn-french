import Foundation
import SwiftUI

class TranslationService: ObservableObject {
    // French to English dictionary with common A2 level words
    private let frenchDictionary: [String: String] = [
        // Basic greetings and common words
        "bonjour": "hello",
        "salut": "hi",
        "au revoir": "goodbye",
        "merci": "thank you",
        "s'il vous plaît": "please",
        "excusez-moi": "excuse me",
        "pardon": "sorry",
        "oui": "yes",
        "non": "no",
        
        // Personal pronouns
        "je": "I",
        "tu": "you (informal)",
        "il": "he",
        "elle": "she",
        "nous": "we",
        "vous": "you (formal/plural)",
        "ils": "they (masculine)",
        "elles": "they (feminine)",
        
        // Common verbs
        "être": "to be",
        "avoir": "to have",
        "faire": "to do/make",
        "aller": "to go",
        "venir": "to come",
        "voir": "to see",
        "parler": "to speak",
        "écouter": "to listen",
        "regarder": "to watch/look",
        "manger": "to eat",
        "boire": "to drink",
        "aimer": "to like/love",
        "vouloir": "to want",
        "pouvoir": "can/be able to",
        "devoir": "must/have to",
        
        // Food and drinks
        "pain": "bread",
        "fromage": "cheese",
        "lait": "milk",
        "eau": "water",
        "café": "coffee",
        "thé": "tea",
        "vin": "wine",
        "bière": "beer",
        "pomme": "apple",
        "banane": "banana",
        "orange": "orange",
        "tomate": "tomato",
        "poulet": "chicken",
        "poisson": "fish",
        "viande": "meat",
        
        // Common nouns
        "maison": "house",
        "voiture": "car",
        "livre": "book",
        "téléphone": "phone",
        "ordinateur": "computer",
        "table": "table",
        "chaise": "chair",
        "fenêtre": "window",
        "porte": "door",
        "temps": "time/weather",
        "jour": "day",
        "nuit": "night",
        "matin": "morning",
        "soir": "evening",
        "semaine": "week",
        "mois": "month",
        "année": "year",
        
        // Adjectives
        "grand": "big/tall",
        "petit": "small",
        "bon": "good",
        "mauvais": "bad",
        "nouveau": "new",
        "vieux": "old",
        "beau": "beautiful",
        "joli": "pretty",
        "chaud": "hot",
        "froid": "cold",
        "facile": "easy",
        "difficile": "difficult",
        
        // Prepositions and articles
        "de": "of/from",
        "à": "to/at",
        "dans": "in",
        "sur": "on",
        "avec": "with",
        "sans": "without",
        "pour": "for",
        "par": "by/through",
        "le": "the (masculine)",
        "la": "the (feminine)",
        "les": "the (plural)",
        "un": "a/an (masculine)",
        "une": "a/an (feminine)",
        "des": "some (plural)",
        "du": "some (masculine partitive)",
        "de la": "some (feminine partitive)",
        
        // Numbers
        "zéro": "zero",
        "deux": "two",
        "trois": "three",
        "quatre": "four",
        "cinq": "five",
        "six": "six",
        "sept": "seven",
        "huit": "eight",
        "neuf": "nine",
        "dix": "ten",
        "cent": "hundred",
        "mille": "thousand",
        
        // Common phrases and expressions
        "comment allez-vous": "how are you",
        "ça va": "it's going well",
        "très bien": "very well",
        "pas mal": "not bad",
        "aujourd'hui": "today",
        "demain": "tomorrow",
        "hier": "yesterday",
        "maintenant": "now",
        "toujours": "always",
        "jamais": "never",
        "parfois": "sometimes",
        "souvent": "often",
        "beaucoup": "a lot",
        "peu": "little",
        "trop": "too much",
        "assez": "enough"
    ]
    
    func translate(_ word: String) async -> String {
        // Simulate network delay for realistic feel
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        let cleanWord = word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check for exact match first
        if let translation = frenchDictionary[cleanWord] {
            return translation
        }
        
        // Check for words with common endings
        let variations = [
            cleanWord.replacingOccurrences(of: "s$", with: "", options: .regularExpression), // plural
            cleanWord.replacingOccurrences(of: "e$", with: "", options: .regularExpression), // feminine
            cleanWord.replacingOccurrences(of: "es$", with: "", options: .regularExpression), // feminine plural
            cleanWord.replacingOccurrences(of: "ent$", with: "er", options: .regularExpression), // verb conjugation
            cleanWord.replacingOccurrences(of: "ons$", with: "er", options: .regularExpression), // verb conjugation
            cleanWord.replacingOccurrences(of: "ez$", with: "er", options: .regularExpression), // verb conjugation
        ]
        
        for variation in variations {
            if let translation = frenchDictionary[variation] {
                return "\(translation) (base form: \(variation))"
            }
        }
        
        // Try to find partial matches for compound words
        let words = cleanWord.components(separatedBy: CharacterSet.alphanumerics.inverted)
        for word in words where word.count > 2 {
            if let translation = frenchDictionary[word.lowercased()] {
                return "Contains '\(word)': \(translation)"
            }
        }
        
        return "Translation not found"
    }
} 
