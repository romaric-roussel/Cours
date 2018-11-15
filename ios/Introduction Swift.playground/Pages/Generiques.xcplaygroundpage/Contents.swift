//: ## Generiques
//:
//: L'écriture d'une fonction générique se fait en écrivant le type entre `<` et `>`.
//: Le type effectif sera subsitué au moment de l'appel.
//:
import Foundation

func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
repeatItem(item: "knock", numberOfTimes: 4)
repeatItem(item: 8, numberOfTimes: 3)

//: Il est important de faire la distinction entre une fonction générique et une fonction qui accepterait n'importe quel type d'objet
//: La fonction repeatUnsafe suivante accepte un élément de n'importe quel type et construit un tableau de type [Any]. Il est alors possible de compléter ce tableau avec des éléments de types différents.

func repeatUnsafe(item: Any, numberOfTimes: Int) -> [Any] {
    var result = [Any]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

var unsafeDates = repeatUnsafe(item: NSDate(), numberOfTimes: 5)
unsafeDates.append("Itchy")
unsafeDates.append(2)
unsafeDates[6]

//: Lors de la relecture dans un tableau de type Any, le compilateur n'a pas moyen de connaître le type de la variable et va la manipuler comme étant de type Any. Il n'est donc pas possible d'écrire :
//: `let x = 4 + unsafeDates[6]`

//: A l'inverse la méthode générique "capture" le type du paramètre lors de l'appel et retourne une valeur dont le type est [NSDate]. Il est possible de le vérifier en faisant un ⎇ + clic sur dates. Si on essaie d'ajouter un élément d'un autre type cela provoque une erreur (visible si on enlève le commentaire).

var dates = repeatItem(item: NSDate(), numberOfTimes: 5)
//dates.append("Ichy")


//: Il est possible d'écrire des fonctions et méthodes génériques, ainsi que des classes, énumerations, et structures.
//:
// Le type optionnel de la librairie standard peut être réimplémenté de la manière suivante :
enum OptionalValue<Wrapped> {
    case None
    case Some(Wrapped)
}

var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

//: Pour contraindre un élément générique à une famille de type il faut utiliser une clause `where` après le nom du type pour exiger par exemple qu'un type implémente un protocole, ou bien que deux types soient les mêmes, ou encore pour exiger qu'une classe ait une superclasse particulière.
//:
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        return false
}
anyCommonElements([1, 2, 3], [3])
anyCommonElements([1, 2, 3], 4...8)
anyCommonElements("toto", "tata")

//: Le protocole Sequence s'applique à tous les types qui supportent le for...in comme les tableaux, les intervalles, les chaînes de caractères (au travers de la méthode `characters`...)
//: Le protocole Equatable définit l'opérateur == qui renvoie true si deux éléments sont égaux (c'est l'équivalent d'une méthode equals redéfinie en Java).

/*:
 * callout(Exercice):
    Créer une fonction `commonElements(_:_:)` qui retournera un tableau contenant les éléments en commun entre les deux séquences. Ce tableau pourra contenir des doublons si un élément est présent plusieurs fois dans chacune des deux collections.
*/

//: Ecrire `<T: Equatable>` est équivalent à `<T where T: Equatable>`.
//:
/*:
 * callout(Exercice):
    Utiliser la syntaxe `if let` pour afficher la liste des élements s'il y a une intersection et un message pour préciser qu'il n'y a aucun élément en commun dans le cas contraire
*/


//: [Previous](@previous) | [Next](@next)
