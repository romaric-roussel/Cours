//: ## Fonctions et Closures
//:
//: Utiliser `func` pour déclarer une fonction, `->` sépare la liste de paramètres du type de retour.
//: A la différence de java, il est possible de déclarer une fonction globale, il n'est pas nécessaire de créer une classe. Cette solution est à utiliser avec des pincettes puisqu'un nom global ne peut être utilisé qu'une fois.
//:
func greet(name: String, day: String, coins :Int) -> String {
    return "Hello \(name), today is \(day), you have \(coins) coins."
}
greet(name: "Bob", day: "Tuesday", coins: 14)
/*:
 * callout(Exercice):
    Ajouter un paramètre coins de type `Int` permettant d'accueillir un joueur en lui annonçant le nombre de pièces qu'il possède.
*/
//: Par défaut, les fonctions utilisent les noms des paramètres comme labels pour leurs arguments (à l'endroit de l'appel de la fonction).
//: Il est possible de spécifier des noms de paramètres différents pour l'appel et pour l'intérieur de la méthode.
//:
func sayHello(to person: String, and anotherPerson: String) -> String {
    return "Hello \(person) and \(anotherPerson)!"
}
print(sayHello(to: "Bill", and: "Ted"))
//: Il est également possible de supprimer les noms des paramètres lors de l'appel en utilisant `_` comme nom de paramètre externe
//:
func add(_ x: Int, _ y:Int) -> Int {
    return x + y
}

add(4, 6)

//: ou encore :
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")
//: On peut également spécifier une valeur par défaut pour un paramètre.
//:
func multiplyBy(_ x: Int, _ y:Int = 2) -> Int {
    return x * y
}

multiplyBy(4, 8)
multiplyBy(4)

func hello(name: String = "Mr. Unknown") -> String {
    return "Hello \(name)"
}

hello()
hello(name:"Germaine Ledoux")

func add(x: Int, y: Int = 42, z: Int = 16) -> Int {
    return x + y + z
}

add(x: 2, y: 4, z: 6)
add(x: 2, y: 4)
add(x: 2, z: 6)

//: On peut utiliser les tuples pour retourner plus d'une valeur. On peut accéder aux éléments d'un tuple par nom ou par position (indice).
//:
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)


//: Les fonctions peuvent avoir un nombre d'arguments variables (*variadic*), ils sont transmis à la fonction sous forme de tableau.
//:



/*:
 * callout(Exercice):
    * Extraire le calcul de la somme dans une fonction sum de type [Int] -> Int à laquelle sumOf délèguera le calcul.

    * Ecrire une fonction moyOf qui prendra un nombre d'arguments variable (de type `Int`) et qui retournera un Double? contenant la moyenne de ses arguments s'il y a au moins un argument et nil sinon (utiliser la clause `guard`).
    * Proposer une alternative moyOf2 permettant de forcer l'utilisateur à fournir au moins 2 arguments.
*/
func sum(_ numbers: [Int])-> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
func sumOf(_ numbers: [Int]) -> Int {
   return sum(numbers)
}
sum([1,2,3])
sumOf([1,2,3])

func moyOf(_ arg:Int...) ->Double?{
    guard arg.count > 0 else {
        return nil
    }
    var somme = 0
    
    for args in arg {
        somme += args
    }
    let result:Double = Double(somme/arg.count)
    return result
}

func moyOf2(_ arg1:Int,_ arg2:Int,_ arg:Int...) ->Double?{
    
    var somme = 0.0
    let result:Double?
    if(arg.count>0){
        somme = Double(arg1 + arg2)
        for args in arg {
            somme += Double(args)
        }
        result = somme/Double((arg.count+2))
    }else {
        somme = Double(arg1 + arg2)
        result = somme/2
    }
    
    return result
}
moyOf2(1,2)

//: Les fonctions peuvent être imbriquées (*nested*). Les fonctions internes ont accès à toutes les variables déclarées dans la fonction externe.
//:
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

//: Les fonctions en Swift sont des objets de première classe :
//:   * elles peuvent être passées comme paramètre à une fonction
//:   * elles peuvent être retournées par une fonction
//:   * elles peuvent être exprimées à l'aide de valeurs littérales (closures)
//:
//: Exemple de fonction retournant une autre fonction :
//:
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)

//: Exemple de fonction prenant une fonction en paramètre :
//:
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

//: Les fonctions sont un cas particulier des closures (*clotures* en français) :
//:   * Une closure est une sorte de fonction anonyme que l'on déclare en l'entourant par des accolades (`{}`).
//:   * Le code dans une closure a accès aux variables et fonctions qui étaient accessibles à l'endroit où la closure a été créée, même si elle se trouve dans un *scope* différent lors de son exécution. Les variables locales sont capturées par la closure pour être utilisables au moment où le code sera effectivement exécuté.
//:   * On utilise `in` pour séparer les arguments et le type de retour du corps.
//:   * elles sont utilisées pour personnaliser des algorithmes ou comme callback (code à exécuter à la fin d'une animation, code à exécuter de manière asynchrone lors de la réception de données depuis un serveur)
//:
//: Les closures viennent du monde de la programmation fonctionnelle où le code est traité au même niveau que les données. Dans certains langages comme le java (à partir de la version 8) ou le python on utilise le terme *expression lambda*. Dans le domaine de la programmation fonctionnelle, il existe 3 fonctions fondamentales qui s'appuient sur les closures pour manipuler des données (en particulier des tableaux) : `map`, `filter` et `reduce`.
//:
//: `map` permet de produire un tableau en appliquant une même transformation à chacun des éléments d'un tableau de départ. Exemple : le code suivant permet d'obtenir un tableau contenant le triple des éléments

var resultArray = numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})

//: - experiment :
//: Réécrire la closure pour retourner 0 pour tous les nombres impairs.
//:
//: La syntaxe des closures peut être allégée. Quand le type est déjà connu, on peut laisser swift inférer le type des paramètres, le type de retour ou les deux. Les closures sur une ligne ont un `return` implicite.
//:
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

//: Simplification d'une closure
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

var reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

//: se simplifie par inférence de type (et réécriture sur une seule ligne)  :

reversedNames = names.sorted(by: { (s1, s2) in return s1 > s2 })

//: en utilisant le return implicite (quand la closure possède une seule ligne) :
reversedNames = names.sorted(by: { (s1, s2) in s1 > s2 })

//: Il est possible de référencer les paramètres par un nombre plutôt que par un nom (ne se justifie que si la closure est courte).
reversedNames = names.sorted(by: { $0 > $1 })

//:Une closure passée en dernier argument d'une fonction peut être déplacée après la parenthèse fermante. Quand la closure est le seul argument, on peut omettre les parenthèses.

reversedNames = names.sorted { $0 > $1 }

//: On peut aller encore plus loin car les opérateurs swift sont des fonctions, on peut donc utiliser directement la fonction `>` ou '<'.
//:
reversedNames = names.sorted(by: >)
print(reversedNames)

let cities = ["Boug-en-Bresse", "Tokyo", "Lyon", "Varsovie", "Bangkok"]
let sortedCities = cities.sorted(by: <)

/*:
 * callout(Exercice):
    Utiliser les intervalles et la méthode `filter` pour afficher un tableau contenant les nombres impairs entre 1 et 21 inclus (en une ligne de code).

 */

/*:
 * callout(Exercice):
    Réécrire la fonction sum en utilisant `reduce`.
 */


/*:
 * callout(Exercice):
    Ecrire une fonction `isLeapYear` permettant de tester si une année est bissextile (vous pouver utiliser un switch case en utilisant les spécificités de swift) et utiliser `filter` pour obtenir la liste des années bissextile entre 1890 et 2020.
 */


//: Un résumé visuel des opérations map/filter/reduce (d'après Steven Luscher)

[🐮,🍠,🐔,🌽].map(cook)                     //[🍔,🍟,🍗,🍿]

[🍔,🍟,🍗,🍿].filter(isVegetarian)          //[🍟,🍿]

[🍔,🍟,🍗,🍿].reduce("",eat)                   //💩



//: [Previous](@previous) | [Next](@next)
