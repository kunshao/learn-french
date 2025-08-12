//
//  ArticleService.swift
//  learn-french
//
//  Created by Kun Shao on 1/7/25.
//

import Foundation

class ArticleService: ObservableObject {
    @Published var currentArticle: FrenchArticle?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Mock French A2 level articles
    private let mockArticles = [
        FrenchArticle(
            id: 1,
            title: "Le Petit Chat",
            content: "Il était une fois un petit chat noir qui vivait dans une maison blanche. Le chat s'appelait Minou et il aimait beaucoup dormir sur le canapé. Chaque matin, il se réveillait tôt pour manger ses croquettes et boire de l'eau fraîche. Minou adorait jouer avec une petite balle rouge et courir dans le jardin. Les enfants de la maison l'aimaient beaucoup et lui donnaient des câlins tous les jours.",
            vocabularyNotes: "Minou = cat (pet name), canapé = sofa, croquettes = dry cat food, câlins = hugs"
        ),
        FrenchArticle(
            id: 2,
            title: "La Belle Jardin",
            content: "Dans notre jardin, il y a beaucoup de belles fleurs colorées. Les roses rouges sont mes préférées car elles sentent très bon. Nous avons aussi des tulipes jaunes et des marguerites blanches. Chaque weekend, ma mère arrose les plantes et enlève les mauvaises herbes. Mon père plante de nouveaux arbres fruitiers. En été, nous mangeons les fraises et les framboises de notre jardin. C'est un endroit merveilleux pour se détendre et profiter de la nature.",
            vocabularyNotes: "jardin = garden, fleurs = flowers, arroser = to water, mauvaises herbes = weeds, se détendre = to relax"
        ),
        FrenchArticle(
            id: 3,
            title: "Mon École",
            content: "Mon école est grande et moderne. Elle a trois étages avec vingt salles de classe. Dans ma classe, nous sommes vingt-cinq élèves. Ma professeure s'appelle Madame Dubois et elle est très gentille. Nous apprenons le français, les mathématiques, l'histoire et la géographie. À midi, nous mangeons à la cantine. L'après-midi, nous avons des cours d'art et de sport. J'aime beaucoup l'école car j'y vois mes amis et j'apprends de nouvelles choses.",
            vocabularyNotes: "étages = floors, salles de classe = classrooms, élèves = students, cantine = cafeteria, art = art"
        ),
        FrenchArticle(
            id: 4,
            title: "Le Week-end",
            content: "Le samedi matin, je me lève tard et je prends mon petit-déjeuner tranquillement. Ensuite, je regarde la télévision ou je joue sur mon ordinateur. L'après-midi, je vais souvent au parc avec mes amis pour jouer au football. Le dimanche, ma famille et moi allons au restaurant ou nous préparons un bon repas à la maison. Parfois, nous visitons mes grands-parents qui habitent dans la ville voisine. Le week-end passe toujours trop vite !",
            vocabularyNotes: "week-end = weekend, petit-déjeuner = breakfast, tranquillement = quietly, ville voisine = neighboring city"
        ),
        FrenchArticle(
            id: 5,
            title: "Les Saisons",
            content: "En France, nous avons quatre saisons. Au printemps, il fait doux et les arbres ont de nouvelles feuilles vertes. L'été est chaud et ensoleillé, parfait pour aller à la plage. En automne, les feuilles deviennent orange et rouges, et il commence à faire froid. L'hiver est froid avec de la neige dans les montagnes. Chaque saison a ses avantages et ses inconvénients. Ma saison préférée est l'été car je peux nager et faire du vélo.",
            vocabularyNotes: "saisons = seasons, doux = mild, ensoleillé = sunny, automne = autumn, avantages = advantages"
        )
    ]
    
    func generateNewArticle() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
        
        // Select a random mock article
        let randomArticle = mockArticles.randomElement() ?? mockArticles[0]
        
        await MainActor.run {
            currentArticle = randomArticle
            isLoading = false
        }
    }
    
    func fetchAllStories() async -> [FrenchArticle] {
        // Return all mock articles
        return mockArticles
    }
} 