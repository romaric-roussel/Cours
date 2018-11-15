//: ## Enumerations et Structures
//:
//: Le mot clé `enum` pour créer une énumeration. Comme les classes et les structures (voir ci-dessous) les énumerations peuvent avoir des méthodes. L'`enum` suivant est défini avec un type de valeur associé à chaque `case` de l'`enum` : ici `Int`. `CaseIterable` permet d'avoir accès à une collection de tous les `cases` de l'`enum` par une propriété `allCases`.
//:
enum Rank: Int, CaseIterable {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue


/*:
 * callout(Exercice):
    Ecrire une fonction highestRank qui prendra deux `Rank` en paramètre et retournera le plus grand des deux, en comparant les valeurs brutes (*raw values*). Tester cette fonction avec un exemple.
*/

//: Dans l'exemple ci-dessus, la valeur brute de l'énumeration est de type `Int`, il n'y a donc qu'à spécifier la première valeur. Les valeurs restantes sont assignées dans l'ordre. Il est également possible d'assigner des chaînes de caractères ou des floats comme valeur brute d'une énumération.
//:
//: `init?(rawValue:)` permet d'obtenir une instance de l'énumération à partir d'une valeur brute. Noter au passage le point d'interrogation (*failable initializer*) qui montre que si l'entier ne correspond pas à un des cas de l'enum l'initialiseur peut retourner `nil`.
//:
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
    print(threeDescription)
}

//: Chacun des cas est une valeur à part entière du type de l'enumération et non pas un alias pour la valeur brute. Dans certaines situations, il n'y a pas de valeur brute ayant du sens et il n'est alors pas nécessaire d'en fournir une..
//:
enum Suit: CaseIterable {
    case Spades, Hearts, Diamonds, Clubs
    
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()

/*:
 * callout(Exercice):
 
    Ajouter une méthode `color()` à `Suit` qui retourne la chaîne “black” pour *spades* (piques) et *clubs* (trèfles), et “red” pour *hearts* (coeurs) and *diamonds* (carreaux).
*/
//: Lorsque l'on fait référence à une des instances d'un enum on utilise soit `Suit.Hearts`, soit `.Hearts` quand le compilateur peut déduire le type avec le contexte (exemple du `switch self`).
//:
//: ### Structures
//:
//: Le mot clé `struct` est utilisé pour créer des structures. Les structures ressemblent de près à des classes : elles possèdent des méthodes, des initialiseurs. L'une des différences les plus importantes entre les structures et les classes est que les structures sont toujours copiées lorsqu'elles sont passées ou assignées, alors que les classes sont passées par référence. En ce sens, les `struct` se comportent comme les structures du C (ou tous les types primitifs en Java). Une deuxième différence majeure est que les `struct` ne supportent pas l'héritage.
//:
//: * `struct` : *value type*
//: * `class` : *reference type*
//:
struct Card {
    
    var rank: Rank
    
    var suit: Suit
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
}
let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

var card = Card(rank: .Five, suit: .Hearts)
var otherCard = card
print("Card : \(card.simpleDescription()) - Other card Card : \(otherCard.simpleDescription())")
//On modifie la couleur de la carte otherCard
otherCard.suit = .Spades
print("Card : \(card.simpleDescription()) - Other card Card : \(otherCard.simpleDescription())")
//Cette modification n'a pas eu d'effet sur la première carte (type valeur => recopie)
/*:
 * callout(Exercice):
    Ajouter une méthode static fullDeck à `Card` pour créer un jeu complet de cartes, avec une carte de chaque combinaison de rang et de couleur. Vérifier que le jeu possède bien 52 cartes.
*/

/*:
 * callout(Exercice):
    Filtrer le jeu de carte obtenu pour obtenir un jeux de 32 cartes (7 jusqu'au roi plus les As)
*/

//: Les structures partagent un certain nombre de traits communs avec les classes. Elles peuvent :
//:
//: * Définir des propriétés pour y stocker des valeurs
//: * Définir des méthodes pour fournir des fonctionnalités
//: * Définir des méthodes subscript pour rendre possible un accès avec la même syntaxe que celle des tableaux et dictionnaires
//: * Définir des initialiseurs pour régler l'état initial
//: * Etre étendues avec des extensions (cf Protocoles et extensions) pour ajouter des fonctionnalités
//: * Se conformer à un protocole

//: On peut associer des valeurs à chaque instance d'un enum. Chaque instance peut avoir des valeurs différentes associées. Ces valeurs sont fournies lors de la création d'une instance. Les valeurs associées et les valeurs brutes sont 2 choses différentes : le type d'une valeur brute est le même pour toutes ses instances, celui de la valeur associée est le même pour toutes les instances du même `case`. La valeur effectivement associée à une instance d'un `case` de l'`enum` est fournie lors de la création.
//:
//: A titre d'exemple, considérons le cas d'une requête auprès d'un serveur pour obtenir les heures de lever et de coucher du soleil. Le serveur répond soit avec l'information, soit avec une erreur.
//:
enum ServerResponse {
    case Result(String, String)
    case Error(String)
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Error("Out of cheese.")

let success2 = ServerResponse.Result("12:00 am", "10:09 pm") // Ne modifie pas les valeurs associées à success

switch success {
    
case let .Result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
    
case let .Error(error):
    print("Failure...  \(error)")
}

/*:
 * callout(Exercice):

    Tester le comportement du switch en cas d'échec
*/

//:### Enumerations récursives
//:
//: Le mot clé `indirect` (qui peut être placé individuellement sur chaque `case` d'un enum ou sur la déclaration de l'enum) permet de déclarer des enum dont la valeur associée est du même type que l'enum.

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let seven = ArithmeticExpression.number(7)
let sum = ArithmeticExpression.addition(five, seven)
let product = ArithmeticExpression.multiplication(sum, .number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let x):
        return x
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

evaluate(product)


//: [Previous](@previous) | [Next](@next)
