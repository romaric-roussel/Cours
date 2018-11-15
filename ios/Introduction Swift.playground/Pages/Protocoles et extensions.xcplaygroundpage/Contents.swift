//: ## Protocoles et Extensions
//:
//: Un `protocol` est semblable à une interface en Java. Il définit un contrat auquel doivent se soumettre les types qui souhaitent se conformer au protocole.
//:
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

//: Les classes, énumerations, et structures peuvent adopter des protocoles.
//:
class SimpleClass: ExampleProtocol {
    
    var simpleDescription: String = "A very simple class."
    
    var anotherProperty: Int = 69105
    
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    
    var simpleDescription: String = "A simple structure"
    
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

/*:
 * callout(Exercice):

    Ecrire une énumération qui se conforme à ce protocole. Les `enum` ne peuvent pas avoir de propriétés stockées, une solution consiste donc pour `adjust` à provoquer un changement de case de l'enum.
*/

//: Le mot clé `mutating` dans la déclaration de `SimpleStructure` permet de signaler les méthodes qui modifient l'état de la structure. La déclaration de `SimpleClass` n'a pas besoin de marquer l'une de ses méthodes comme `mutating` car les méthodes d'une classe peuvent toujours modifier l'état de la classe.
/*:
 * callout(Exercice):
    Remplacer la déclaration des variables de type SimpleClass et SimpleStructure par des constantes (`let`) afin de mettre en évidence le rôle du mot clé `mutating` et la différence de comportement entre les types références et les types valeurs.
 */

//: Le mot clé `extension` permet d'ajouter des fonctionnalités à un type existant : nouvelles méthodes ou nouvelles propriétés calculées. On les utilise pour séparer le code permettant d'adopter un protocol, pour découper le code d'une classe en plusieurs fichiers, pour ajouter des méthodes à un type importé d'une bibliothèque ou d'un framework. Si une classe adopte des protocoles différents pour gérer des aspects liés à la vue de l'application ou bien à la sauvegarde en base de données, l'adoption de ces protocoles doit se faire dans les fichiers appropriés afin de bien conserver la séparation entre les différentes responsabilités.
//:
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)
var x = 12
x.adjust()
print(x)

/*:
 * callout(Exercice):
    Ecrire une extension pour le type `Double` qui ajoute une propriété `absoluteValue`.
*/

//: Un nom de protocole peut servir de type à une variable (polymorphisme) : dans ce cas, seules les méthodes et propriétés définies dans le protocole sont diponibles.
//:
var protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// print(protocolValue.anotherProperty)  // Uncomment to see the error

//: Bien que la variable `protocolValue` ait le type `SimpleClass`, lors de l'exécution le compilateur la traite comme étant du type `ExampleProtocol` (voir l'effet en enlevant les commentaires, rien de ce qui est spécifique à la classe n'est accessible).
//:
//: Cette variable peut stocker n'importe quel objet/structure/enum qui implémente le protocole ExampleProtocol
//:
protocolValue = b
print(protocolValue.simpleDescription)

//: Remarque : pour les `enums`, `CaseIterable` est un protocole. Lorsque le compilateur rencontre cette déclaration il génère la liste de tous les `cases` de l'`enum`.

//: [Previous](@previous) | [Next](@next)
