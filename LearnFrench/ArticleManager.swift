import Foundation

class ArticleManager: ObservableObject {
    @Published var currentArticle: FrenchArticle?
    
    private let articles: [FrenchArticle] = [
        FrenchArticle(
            title: "Ma Famille",
            content: "Je m'appelle Marie et j'ai vingt-cinq ans. J'habite à Paris avec ma famille. Mon père s'appelle Pierre et il est ingénieur. Ma mère s'appelle Sophie et elle est professeur. J'ai un frère qui s'appelle Thomas. Il a vingt-deux ans et il étudie à l'université. Ma sœur s'appelle Julie et elle a dix-neuf ans. Elle va au lycée. Nous avons aussi un chat qui s'appelle Minou. Le weekend, nous aimons aller au parc ensemble.",
            vocabulary: [
                "m'appelle": "my name is",
                "j'ai": "I have",
                "j'habite": "I live",
                "s'appelle": "is called",
                "ingénieur": "engineer",
                "professeur": "teacher",
                "frère": "brother",
                "sœur": "sister",
                "étudie": "studies",
                "université": "university",
                "lycée": "high school",
                "chat": "cat",
                "weekend": "weekend",
                "parc": "park"
            ]
        ),
        FrenchArticle(
            title: "Ma Maison",
            content: "J'habite dans un appartement au centre-ville. Mon appartement a trois pièces : un salon, une cuisine et une chambre. Dans le salon, il y a un canapé, une télévision et une bibliothèque. La cuisine est petite mais pratique. Il y a une table, des chaises et un réfrigérateur. Ma chambre est confortable avec un lit, un bureau et une armoire. J'ai aussi un balcon où je peux voir la rue. L'appartement est au troisième étage et il y a un ascenseur.",
            vocabulary: [
                "appartement": "apartment",
                "centre-ville": "city center",
                "pièces": "rooms",
                "salon": "living room",
                "cuisine": "kitchen",
                "chambre": "bedroom",
                "canapé": "sofa",
                "télévision": "television",
                "bibliothèque": "bookshelf",
                "pratique": "practical",
                "réfrigérateur": "refrigerator",
                "confortable": "comfortable",
                "bureau": "desk",
                "armoire": "wardrobe",
                "balcon": "balcony",
                "étage": "floor",
                "ascenseur": "elevator"
            ]
        ),
        FrenchArticle(
            title: "Mon Travail",
            content: "Je travaille dans un bureau du lundi au vendredi. Mon travail commence à neuf heures du matin et finit à cinq heures de l'après-midi. Je suis secrétaire dans une grande entreprise. Mon bureau est au deuxième étage. J'ai un ordinateur sur mon bureau et je passe beaucoup de temps à taper des documents. Mes collègues sont très sympas. Nous prenons une pause à midi pour déjeuner ensemble. Le vendredi soir, nous allons souvent boire un verre après le travail.",
            vocabulary: [
                "travaille": "work",
                "bureau": "office",
                "lundi": "Monday",
                "vendredi": "Friday",
                "commence": "starts",
                "finit": "ends",
                "secrétaire": "secretary",
                "entreprise": "company",
                "ordinateur": "computer",
                "taper": "type",
                "documents": "documents",
                "collègues": "colleagues",
                "sympas": "nice",
                "pause": "break",
                "déjeuner": "lunch",
                "verre": "drink"
            ]
        ),
        FrenchArticle(
            title: "Mes Loisirs",
            content: "J'aime beaucoup lire des livres et regarder des films. Le weekend, je vais souvent au cinéma avec mes amis. J'aime aussi faire du sport. Je fais du jogging trois fois par semaine dans le parc près de chez moi. Parfois, je vais à la piscine pour nager. En été, j'aime aller à la plage avec ma famille. Nous faisons des pique-niques et nous jouons au volley-ball. J'aime aussi cuisiner. Je prépare souvent le dîner pour ma famille.",
            vocabulary: [
                "loisirs": "hobbies",
                "lire": "read",
                "livres": "books",
                "regarder": "watch",
                "films": "movies",
                "cinéma": "cinema",
                "sport": "sport",
                "jogging": "jogging",
                "piscine": "swimming pool",
                "nager": "swim",
                "plage": "beach",
                "pique-niques": "picnics",
                "volley-ball": "volleyball",
                "cuisiner": "cook",
                "prépare": "prepare",
                "dîner": "dinner"
            ]
        ),
        FrenchArticle(
            title: "Le Petit Déjeuner",
            content: "Le matin, je me lève à sept heures. Je vais dans la salle de bain pour me laver et me brosser les dents. Ensuite, je vais dans la cuisine pour préparer mon petit déjeuner. Je mange des céréales avec du lait et je bois un jus d'orange. Parfois, je mange aussi du pain avec du beurre et de la confiture. Je bois du café ou du thé. Après le petit déjeuner, je me brosse les cheveux et je m'habille. Je prends mon sac et je pars au travail.",
            vocabulary: [
                "petit déjeuner": "breakfast",
                "me lève": "get up",
                "salle de bain": "bathroom",
                "me laver": "wash myself",
                "brosser": "brush",
                "dents": "teeth",
                "cuisine": "kitchen",
                "préparer": "prepare",
                "céréales": "cereal",
                "lait": "milk",
                "jus d'orange": "orange juice",
                "pain": "bread",
                "beurre": "butter",
                "confiture": "jam",
                "café": "coffee",
                "thé": "tea",
                "cheveux": "hair",
                "m'habille": "get dressed",
                "sac": "bag"
            ]
        )
    ]
    
    init() {
        getRandomArticle()
    }
    
    func getRandomArticle() {
        currentArticle = articles.randomElement()
    }
} 