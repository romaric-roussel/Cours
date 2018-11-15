//: ## Objets et Classes
//:
//: Utilisation du mot clé `class`.
//:
import UIKit

class Shape {
    var numberOfSides = 0
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

/*:
 * callout(Exercice):
    Ajouter une propriété constante color de type `UIColor` avec le mot clé `let` et l'initialiser à bleu (UIColor possède des propriétés pour récupérer les couleurs de base). Ajouter une autre méthode qui prend en argument un autre objet de type Shape et qui affiche si l'autre objet a plus ou moins de côtés.
*/
//: On crée une instance d'une classe en faisant suivre le nom de la classe par des parenthèses. 
//:
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

//: La classe précédente ne possède pas d'initialiseur (équivalent des constructeurs). On utilise `init` pour en créer un.
//:
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//: `self` est utilisée de la même manière que `this` en java pour distinguer la propriété `name` du paramètre `name`. Toute les propriétés doivent être initialisées soit lors de leur déclaration soit dans l'initialiseur.
//:
//: Utiliser `deinit` si vous avez besoin de faire du ménage lorsqu'un objet est désalloué (fermer des fichiers, connexions réseau, ...).
//:
//: Pour l'héritage, on fait suivre le nom de la classe par le nom de la superclasse séparés par `:`. Il n'est pas nécessaire d'hériter d'une classe particulière.
//:
//: On redéfinit une méthode en la faisant précéder par le mot clé `override`. Le compilateur détecte donc les redéfinitions accidentelles ou les erreurs liées à la redéfinition d'une méthode qui n'existe pas.
//:
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() ->  Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

/*:
 * callout(Exercice):
    Créer une autre sous-classe de `NamedShape` appelée `Circle` dont l'initialiseur prendra le rayon et un nom comme arguments. Implémenter la méthode `area()` et `simpleDescription()` pour le cercle.
*/

//: Il existe deux types de propriétés *stored properties* et *computed properties* qui sont définies en fournissant un getter et/ou un setter.
//:
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)

//: Dans le setter de `perimeter`, la nouvelle valeur a le nom implicite `newValue`. Il est possible de fournir un nom explicite après `set`: set(newPerimeter) {...}.
//:
//: L'initialisation de la classe `EquilateralTriangle` se fait en 3 étapes :
//:
//: 1. Affectation des valeurs aux propriétés déclarées par la sous-classe.
//:
//: 1. Appel de l'initaliseur de la superclasse.
//:
//: 1. Modification des propriétés définies dans la superclasse. A partir de cette étape l'objet est complètement initialisé et ses méthodes, getters, et setters peuvent être appelés sans risque.
//:
//: Les propriétés calculées n'ont pas de stockage associé au niveau de la classe. En Java on les aurait implémentées à l'aide de méthodes. Cela permet d'éviter de stocker des informations redondantes.
//:
//: Si on n'a pas besoin de calculer la propriété mais qu'on veut exécuter du code avant ou après l'exécution d'un setter d'une propriétée stockée (*stored property*) il faut utiliser `willSet` et `didSet`. Le code fourni dans ces méthodes est exécuté à chaque fois que la propriété change en dehors d'un initialiseur. Par exemple, la classe ci-dessous s'assure que la longueur d'un côté de son triangle est toujours égale à la longueur d'un côté de son carré.
//:
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)

//: Lorsque l'on travaille avec des variables optionnelles, il faut utiliser un `?` avant l'appel d'une méthode, l'accès à une propriété, ou encore l'accès à une case d'un tableau. Si la valeur avant le `?` est `nil`, tout ce qui suit le `?` est ignoré et la valeur retournée par l'ensemble de l'expression est `nil`. Sinon, la valeur optionnelle est déballée (*unwrapped*), et l'accès se poursuit. Dans un cas comme dans l'autre le résultat de la ligne est une variable optionnelle.
//:
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength

let numbers: [Int]? = Array(1...10)
numbers?[3]

//: Egalité vs identité
//: Swift utilise l'opérateur `==` pour tester l'égalité et l'opérateur `===` pour tester l'identité.
//: L'égalité entre deux instances d'une même classe est implémentée en surchargeant l'opérateur `==`. Cet opérateur n'est pas défini dans une classe car il n'est pas invoqué sur une instance, il s'agit d'une surcharge de l'opérateur `==` qui appartient au *namespace* global.
class Person {
    var name: String
    var firstName: String
    
    init(name: String, firstName: String) {
        self.name = name
        self.firstName = firstName
    }
}

func ==(lhs: Person, rhs: Person) -> Bool {
    return (lhs.name == rhs.name) && (lhs.firstName == rhs.firstName)
}

let john = Person(name: "Deuf", firstName: "John")
let john2 = Person(name: "Deuf", firstName: "John")
john == john2
john === john2

//: Les classes qui héritent d'une super-classe peuvent hériter d'un opérateur d'égalité.


//: [Previous](@previous) | [Next](@next)
