//: ## Optionals
//:
//: Les valeurs optionnelles sont très présentes en Swift et il est fondamental de les maîtriser.
//: Une valeur optionnelle signifie
//:
//:  - Il y a une valeur et elle est égale à x
//:
//: ou
//:
//:  - Il n'y a pas de valeur du tout
//:
//: Les optionnels sont très utilisés pour les types de retour des fonctions qui peuvent échouer
//:
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

//: La création d'un entier à partir d'un chaîne de caractère pourrait échouer si la chaîne de caractère n'a pas le bon format. Le type de convertedNumber est donc `Int?`

//: Une situation dans laquelle on rencontre fréquemment les optionnels est celle d'une variable qu'on n'est pas en mesure d'initialiser lors de sa déclaration ou de sa création (variable d'instance qui pourrait servir à créer un lien avec un autre objet plus tard).
//:
var surveyAnswer: String?
//surveyAnswer est égal à `nil`
//: Avant d'accéder à une variable de type optionnel, il est nécessaire de vérifier si elle est égale à `nil` afin de se prémunir contre une erreur. Il est possible de le faire par la syntaxe classique suivante :
//:
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}

//: Lorsque l'on est sûr que la variable contient bien une valeur on peut forcer le déballage (*forced unwrapping*) en utilisant l'opérateur `!`
//:
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}

//: L'approche la plus adaptée consiste à combiner le test et le déballage en effectuant ce qui est nommé un *optional binding* à l'aide de la construction `if let` :
//:
if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}

//: Afin d'éviter une cascade de `if let` imbriqués (plus connue sous le nom de *pyramid of doom* ou pyramide de la mort), il est possible d'effectuer plusieurs déballages dans un même `if let`
//:
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber {
    print("\(firstNumber) < \(secondNumber)")
}

//: Dans certaines situations, il est clair d'après la structure du programme qu'une variable ne pourra jamais être égale à `nil`, il est alors possible (mais risqué) de déclarer cette variable comme étant *implicitly unwrapped optional*
//:
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // nécessite un point d'exclamation

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // pas besoin de point d'exclamation


//: ## Transtypage - *Down casting*
//:
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//: L'opérateur `is` permet de tester le type d'un objet
//:

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")

//: L'opérateur `as?` permet de caster un objet vers un type plus spécifique. Le résultat est un optionnel afin de tenir compte du cas de figure où le cast n'est pas possible.
//:

for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)")
    }
}
//: ## AnyObject
//: Lorsque l'on travaille avec des API Cocoa (écrites en Objective-C), il est courant de recevoir un tableau dont le type est [AnyObject], ou “un tableau d'objets de n'importe quel type”. Le langage Objective-C ne possède pas de mécanisme pour typer les collections (génériques). Cependant on peut généralement être sûr du type des objets contenus dans un tableau (en connaissant la méthode qui a permis de l'obtenir).
//:
//: Dans ces situations, il est possible d'utiliser la version forcée de l'opérateur de transtypage (`as!`) pour forcer le cast sans avoir recours à un déballage d'optionnels (optional unwrapping).
//:
//: L'exemple ci-dessous définit un tableau de type [AnyObject] et le remplit avec trois instances de la classe Movie :

let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
//: Une première stratégie consiste à parcourir le tableau et à utiliser l'opérateur de transtypage forcé sur chaque item :

for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}

//: Il est également possible de transtyper d'un coup la totalité du tableau :

    for movie in someObjects as! [Movie] {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
}

//: ## Any
//:  - AnyObject peut représenter une instance de n'importe quelle classe.
//:  - Any peut représenter une instance de n'importe quel type (y compris les structs ou les fonctions).
//: Exemple d'usage d'Any pour travailler avec un mix de types :

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })
//: Le tableau things contient deux Int, deux Double, une String, un tuple de type (Double, Double), le film “Ghostbusters”, et une closure qui prend une String et retourne une autre String.
//:
//: On peut utiliser les opérateurs `is` et `as` dans un switch :

    for thing in things {
        switch thing {
        case 0 as Int:
            print("zero as an Int")
        case 0 as Double:
            print("zero as a Double")
        case let someInt as Int:
            print("an integer value of \(someInt)")
        case let someDouble as Double where someDouble > 0:
            print("a positive double value of \(someDouble)")
        case is Double:
            print("some other double value that I don't want to print")
        case let someString as String:
            print("a string value of \"\(someString)\"")
        case let (x, y) as (Double, Double):
            print("an (x, y) point at \(x), \(y)")
        case let movie as Movie:
            print("a movie called '\(movie.name)', dir. \(movie.director)")
        case let stringConverter as (String) -> String:
            print(stringConverter("Michael"))
        default:
            print("something else")
        }
}
//: ## *Optional chaining*
//: L'usage du `?` permet de parcourir une chaîne de liens entre des objets qui pourrait être brisée en tout point par une référence nil.
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

//let roomCount = john.residence!.numberOfRooms
let roomCount = john.residence?.numberOfRooms

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
//: [Previous](@previous) | [Next](@next)
