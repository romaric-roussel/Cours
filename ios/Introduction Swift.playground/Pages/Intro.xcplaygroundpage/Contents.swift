//: # Introduction rapide à la syntaxe Swift
//:
//: Cette introduction est fortement inspirée du playground *A Swift Tour* (qui constitue l'introduction du livre de description de la syntaxe Swift d'Apple : [The Swift Programming Language](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html#//apple_ref/doc/uid/TP40014097-CH2-ID1)
//:
//: ## Le traditionnel Hello World !
//: L'affichage d'un texte se fait par appel de la fonction print:
//:
print("coucou")

//: Cette ligne est un programme swift valide. Il n'y a pas besoin d'importer des librairies, ni de définir de fonction main(). Il n'y a pas de points virgules à la fin des lignes de code.
//: Le playground est un environnement interactif pour interagir avec le code. Vous pouvez modifier le texte présent dans la fonction print.
//:
//: Il est possible d'écrire des scripts en swift. Vous pouvez créer un fichier test.swift contenant le code suivant :
//:
//:        #!/usr/bin/swift
//:        print("Hello World!")
//: Puis le rendre executable avec un chmod +x test.swift
//: Il est alors possible de l'exécuter en faisant ./test.swift

//:
//: ## Variables et constantes
//:
//: On utilise les mots clés `let` pour créer une constante et `var` pour créer une variable. La valeur d'une constante `let` ne doit pas nécessairement être affectée lors de la création de la variable mais elle ne pourra l'être qu'une seule fois (similaire à `final` en Java). De manière générale, on privilégiera les constantes.
//:
var myVariable = 43
myVariable = 50
let myConstant = 42


//: Les constantes et les variables doivent avoir le même type que les valeurs qu'on leur assigne. Cependant il est rarement nécessaire de préciser le type explicitement. Lorsqu'une valeur initiale est fournie, le compilateur Swift utilise l'inférence de type. Dans l'exemple ci-dessus, le compilateur déduit (infère) que la variable myVariable est de type entier (`Int`).
//: Pour connaitre le type inféré par le compilateur, il faut faire un ⎇ + clic sur la variable.
//: Vérifier les types inférés pour myVariable et myConstant.
//:
//: Si la valeur initiale ne permet pas au compilateur de déduire le type (ou s'il n'y a pas de valeur initiale), il est possible de faire suivre le nom de la variable (ou constante) par `:` suivis du type.
//:
let implicitInteger = 70
let implicitBigInteger = 1_000_000 //Un million
let implicitDouble = 70.0
let explicitDouble: Double = 70

//: Les principaux types de bases sont : `Bool`, `Int` et `UInt` (`Int8`, `UInt8`, `Int16`, `UInt16`, ...), `Float` (32 bits), `Double` (64 bits)

var green: UInt8 = 0xC7
var red: Float = 36

//: Par défaut le débordement provoque une erreur (enlever le commentaire sur l'addition ci-dessous)
//:
green = UInt8.max
//green = green &+ 1

//: Pour les cas où le débordement est souhaité il faut utiliser un opérateur d'addition spécial `&+`
//:
green = UInt8.max
green = green &+ 1

//: Pour améliorer la lisibilité du code, il est également possible de définir un alias pour un type
//:
typealias AudioSample = UInt16

let sample: AudioSample = 126

/*:
 * callout(Exercice):
    Créer une constante avec un type explicite `Float` et une valeur de `4`.
*/
typealias alias = Float
let contante: alias = 4
//: Swift est un langage fortement typé. Il n'y a pas de conversion implicite de type.
//:
let label = "The width is "
let width = 94
let widthLabel = label + String(width)

/*:
 * callout(Exercice):
    Essayez de supprimer la conversion en chaîne dans la dernière ligne. Quelle erreur obtenez-vous ?
*/
//: La construction de chaînes de caractères à partir de valeurs contenues dans des variables (ou constantes) peut se faire simplement en plaçant l'expression souhaitée directement au sein des chaînes entre parenthèses en faisant précéder ces parenthèses d'un antislash (`\`). Exemple:
//:
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

/*:
 * callout(Exercice):
    Utiliser `\()` pour inclure un calcul en flottant dans une chaîne et le nom d'une personne dans un message d'accueil..
*/
let pommes: Float = 3
let poires: Float = 5
let panierDeFruit = "Bonjour monsieur.Voulez vous \(pommes * poires) fruit ?"
//: Cette syntaxe est très pratique mais elle ne permet pas de maitriser le format des nombres. Si on a besoin de formatteurs classiques (C, Java, ...), il faut utiliser des méthodes de la classe String (et importer le framework Foundation)
import Foundation
let π = Double.pi
let racine = sqrt(36)
let chaineRacine = String(format: "√ %.2f", racine)
let maChaineMaster = String(format: "π = %.2f", π)

//:
//: ## Tableaux et dictionnaires
//:
//: Les tableaux et dictionnaires (équivalent des `Map` en Java) sont créer à l'aide des crochets (`[]`). L'accès aux éléments se fait également avec les crochets par indice ou par clé. Les dictionnaires séparent les clés des valeurs par `:`.
//:
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
shoppingList.count
shoppingList.append("eggs")
shoppingList += ["Milk"]  //Autre manière d'ajouter un élément

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
print(occupations)
shoppingList.insert("romaric", at: 0)
//: Pour créer une collection vide on peut utiliser la syntaxe suivante.
//:
let emptyArray = [String]()
let emptyDictionary = [String: Float]()

//: Si la variable a déjà été déclarée, il est également possible de s'appuyer sur l'inférence de type pour simplifier l'expression.
//:
shoppingList = [] //Tableau vide
occupations = [:] //Dictionnaire vide
print(shoppingList)
//: A noter qu'il est également possible d'utiliser la syntaxe suivante :
//:
shoppingList = Array<String>()
occupations = Dictionary<String, String>()

//: ## Tuples
//:
//: Les *tuples* rassemblent plusieurs variables (potentiellement de types différents) dans une même variable.

let http404Error = (404, "Not Found")
// http404Error est du type (Int, String)

//: Décomposition d'un tuple
//:
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

//: Décomposition d'un tuple en ignorant une partie
//:
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

//: Accès par indice
//:
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

//: Accès par nom
//:
let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")


//: [Next](@next)
