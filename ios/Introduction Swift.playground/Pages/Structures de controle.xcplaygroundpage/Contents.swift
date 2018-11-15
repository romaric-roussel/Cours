//: ## Structures de contrôle du flot d'exécution
//:
//: Les principales structures de contrôle sont `if` et `switch` pour les conditions, et `for`-`in`, `for`, `while`, and `repeat`-`while`, `continue` et `break` pour les boucles. On rencontre également `guard`, `defer`, `throw` et `try - catch` dans le contexte de la gestion des erreurs. Les parenthèses autour des conditions ou des variables de boucles sont optionnelles. Les accolades autour du corps sont obligatoires.
//:
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

//: A la différence du C la condition d'un `if` doit être une expression booléenne: `if score { ... }` est une erreur, et non pas une comparaison implicite à zéro.
//:
//: Exemple avec enchainement de `else if` :

let temperatureInFahrenheit = 33
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}

//: ## Les variables optionnelles - *Optionals*
//:
//: Swift utilise le concept de valeurs optionnelles afin de gérer le problème récurrent des références nulles. 
//:
//: En swift une variable normale ne peut pas contenir la valeur `nil`.
//:
//: Si on a besoin de créer une variable qui peut contenir la valeur `nil` (soit parce qu'il s'agit d'un lien facultatif avec une autre classe, soit parce que la valeur ne peut pas être connue au moment de la création de l'objet) doit être marquée comme optionnelle en ajoutant un `?` après le type de la variable.
//:
//: On peut utiliser `if let` pour travailler avec des valeurs qui pourraient être manquantes. Cette approche force à considérer le cas et permet d'éviter des crash d'application liés à une tentative d'accès à un objet qui n'existe pas. Une valeur optionnelle contient soit une valeur soit `nil` pour indiquer l'absence de valeur. La construction `if let` permet de tenter d'extraire la valeur optionnelle et de tester la réussite de cette opération.
//:
//: Les valeurs optionnelles sont également très utilisées comme valeur de retour d'une fonction dont l'exécution n'a pas pu produire le résulat attendu. Elles permettent une gestion simple des erreurs.
//:
var optionalString: String? = "Hello"
print(optionalString == "Hello")

var optionalName: String? = "coucou"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
} else {
    greeting = "Hello"
}

/*:
 * callout(Exercice):
    Mettre le contenu de la variable `optionalName` à `nil`. Quel message `greeting` obtenez-vous ? Ajouter une clause `else` pour modifier le message d'accueil (`greeting`) si `optionalName` est `nil`.
*/

//: Si la valeur optionnelle est `nil`, la condition est `false`.
//: Dans le cas contraire, la valeur optionnelle est *déballée* (*unwrapped*) et assignée à la constante après `let`, qui rend la valeur déballée disponible à l'intérieur du bloc de code.
//:
//: Une autre approche pour traiter les valeurs optionnelles est d'utiliser l'opérateur `??` qui permet de renvoyer une valeur par défaut si la valeur est manquante et de déballer l'optionnelle dans le cas contraire.

let nickName: String? = "pop"
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"

/*:
 * callout(Exercice):
    Modifier `nickName` afin de tester le comportement de l'opérateur `??`.
*/

//: ## Switch
//:
//:Le `switch` en swift est très complet et puissant. Il supporte tout type de donnée et des comparaisons pour chaque `case` qui ne sont pas limitées à des simples tests d'égalité.

let vegetable = "red pepper"

switch vegetable {
    
case "celery":
    print("Add some raisins and make ants on a log.")
    
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
    
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
    
default:
    print("Everything tastes good in soup.")
}

/*:
 * callout(Exercice):
    Essayez de supprimer le cas par défaut. Quelle erreur obtenez-vous ?
*/
//: Remarquez l'usage des mots clés `let` et `where` qui permettent d'intercepter avec un case un grand nombre de cas de figure et de récupérer la valeur satisfaisant le *pattern* pour l'assigner à une constante.
//:
//: Après exécution du code à l'intérieur d'un `case`, le programme sort du `switch`. L'exécution ne se poursuit pas par le cas suivant. Il n'y a donc pas besoin de `break` à la fin de chaque `case`. Si on souhaite effectivement que deux `case` s'enchaînent il faut le faire explicitement avec le mot clé `fallthrough`.

let someCharacter: Character = "e"

switch someCharacter {
    
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
    
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
"n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
    
default:
    print("\(someCharacter) is not a vowel or a consonant")
}


let anotherCharacter: Character = "a"

switch anotherCharacter {
    
case "a":
    fallthrough
case "A":
    print("The letter A")
    
default:
    print("Not the letter A")
}

//: ## Boucles
//: On utilise la construction `for`-`in` pour parcourir un tableau ou un dictionnaire. 
//:
let myArray = [1, 1, 2, 4, 5]
for value in myArray {
    if value == 1 {
        print("One!")
    } else {
        print("Not one!")
    }
}

//: Il est possible d'itérer sur un grand nombre de classes (les chaînes en font partie). On peut utiliser `continue` pour passer directement à l'itération suivante.
let puzzleInput = "great minds think alike"

var puzzleOutput = ""

for character in puzzleInput {
    switch character {

    case "a", "e", "i", "o", "u", " ":
        continue
    
    default:
        puzzleOutput.append(character)
    }
}

print(puzzleOutput)

//: Si on a également besoin de connaître l'indice de l'élément en cours la solution consiste à utiliser la méthode enumerate() qui retourne un *tuple* (paire de variable) contenant l'indice et la valeur en cours.
//:

let goal = 4

for (index, value) in myArray.enumerated() {
    if value == goal {
        print("I found \(value) at index \(index)")
    }
}

//: Dans le cas d'un dictionnaire chaque itération retourne un *tuple* contenant la clé et la valeur associée. Les dictionnaires sont des collections non ordonnées, l'ordre d'itération est arbitraire.
//:

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 43, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]

var maxNumberByCategory = [String:Int]()
var largest = 0
var category :String? = "rien"
for (categories, numbers) in interestingNumbers {
    for number in numbers {
        if number > maxNumberByCategory[categories, default:0] {
        
            maxNumberByCategory[categories] = number
            //category = categories
        }
    }
}
print(largest)
print(maxNumberByCategory)

/*:
 * callout(Exercice):
    Ajouter une autre variable pour mémoriser et afficher la catégorie qui contenait le nombre le plus grand (Prime, Fibonacci ou Square).
*/

/*:
 * callout(Exercice):
 Reprendre le code précédent en mémorisant dans un dictionnaire les valeurs maximales pour chaque catégorie de nombres en utilisant la méthode `subscript(_:default:)` de la classe Dictionary. Remarque : la méthode subscript permet de surcharger l'opérateur `[]`. Un accès `my_dict[key]` retourne une valeur optionnelle alors que `my_dict[key, default:12])` retourne une valeur non optionnelle ou 12 si la clé n'était pas présente.
 */

//: Les boucles `while` ressemblent à celles du C et du Java à la différence près qu'on utilise le mot clé `repeat` plutôt que `do`.
var n = 2
while n < 100 {
    n = n * 2
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)


//: Lorque l'on souhaite effectuer un nombre d'itération spécifique, on utilise `for - in` avec un intervalle de nombre.
//:
var firstForLoop = 0
for i in 0..<4 {
    firstForLoop += i
}
print(firstForLoop)

//: Utiliser `..<` pour créer une plage de nombre qui exclue la borne haute et utiliser `...` pour créer une plage de valeurs qui inclue les deux extrémités.
//:

var tab = [Int]()
for i in -2...2 {
    tab += [i]
}
tab
tab += [3]
print(tab)

//: L'exemple ci-dessus contruit un tableau initialement vide
//: A chaque itération de la boucle for on crée un nouveau tableau qui contient un seul élément : `[i]`
//: que l'on ajoute (*append*) à la fin du tableau.
//:On obtiendrait le même résultat avec le code suivant :
for i in -2...2 {
    tab.append(i)
}
tab

//: On pourrait également utiliser la syntaxe :
tab = Array(-2...2)

/*:
 * callout(Exercice):
    Utiliser une boucle for pour afficher la table de multiplication de 8.
*/
var tableDeHuit = [Int]()
for i in 0...10 {
    tableDeHuit[i] = (8*i)
}
print(tableDeHuit)

//: Si la valeur de compteur de boucle n'est pas utilisée par le corps de la boucle, on peut remplacer le nom de la variable par `_`.
//:


let base = 2
let power = 10
var result = 1

for _ in 1...power {
    result *= base
}

print("\(base) to the power \(power) is \(result)")

//: ## Utilisation avancée du `switch`
//:
//: Utilisation des intervalles

let approximateCount = 62

let countedThings = "moons orbiting Saturn"

var naturalCount: String = ""

switch approximateCount {
case 0:
    naturalCount = "no"
    
case 1..<5:
    naturalCount = "a few"
    
case 5..<12:
    naturalCount = "several"
    
case 12..<100:
    naturalCount = "dozens of"
    
case 100..<1000:
    naturalCount = "hundreds of"
    
default:
    naturalCount = "many"
}

print("There are \(naturalCount) \(countedThings).")

//: Switch sur des tuples
//:
let somePoint = (1, 1)

switch somePoint {
    
case (0, 0):
    print("(0, 0) is at the origin")
    
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
    
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
    
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
    
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

//: Switch avec récupération de la valeur (*value binding*)
//:

let anotherPoint = (2, 0)

switch anotherPoint {
    
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
    
case (0, let y):
    print("on the y-axis with a y value of \(y)")
    
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

//: Switch avec des clauses `where` (*value binding*)
//:
let yetAnotherPoint = (1, -1)

switch yetAnotherPoint {
    
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
    
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
    
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
//: ## Guard
//:
//: `guard` ressemble à un `if`. `guard` est utilisé pour expliciter qu'une condition doit être vraie afin de poursuivre l'exécution du code. A la différence d'un `if`, `guard` possède toujours une clause `else` dont le code est exécutée si la condition est fausse.
//: Utiliser `guard` plutôt que `if` permet d'expliciter l'intention du test et d'éviter une cascade de `if` imbriqués.
//: `guard` est fréquemment utilisé pour valider les arguments passés à une fonction et lancer une exception si les conditions ne sont pas remplies.
//: Les variables affectées dans la close `guard` sont accessibles dans le reste de la fonction (cette clause est fréquemment utilisée pour "déballer" des optionnels.

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])

/*:
 * callout(Exercice):
    Compléter la fonction `greetWithIf` ayant le même comportement que la fonction `greet` sans utiliser la clause `guard` mais uniquement des `if` sans avoir recours à des `return` anticipés.
*/

func greetWithIf(person: [String: String]) {

    
}

greetWithIf(person: ["name": "John"])
greetWithIf(person: ["name": "Jane", "location": "Cupertino"])


//: [Previous](@previous) | [Next](@next)
