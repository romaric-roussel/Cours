//: ## Gestion des erreurs
//:
//: Les erreurs sont représentées par tout type qui adopte le protocole `Error`.
//:
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

//: On lance un erreur avec le mot clé `throw`. On utilise le mot clé `throws` pour indiquer qu'une fonction ou méthode peut lancer une erreur. Dès qu'une erreur est lancée dans une fonction, celle-ci retourne immédiatement et le code qui a appelé la fonction traite l'erreur.
//:
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}

//: Il y a plusieurs façons de gérer les erreurs. Une solution consiste à utiliser une structure `do`-`catch`. A l'intérieur du bloc `do`, on marque les appels de code susceptibles de lancer une erreur en les précédant par `try`. A l'intérieur du bloc `catch`, l'erreur reçoit automatiquement le nom `error` sauf si on précise un nom différent.
//:
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printerResponse)
} catch {
    print(error)
}

//: - callout(Exercice):
//: Modifier le nom de l'imprimante en `"Never Has Toner"`, de manière à ce que la fonction `send(job:toPrinter:)` lance une erreur.
//:
//: On peut écrire plusieurs blocs `catch` pour traiter chaque erreur de façon spécifique. La sélection de l'erreur se fait avec un pattern construit sur le modèle des `case` du `switch`.
//:


do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}

//: - callout(Exercice):
//: Ajouter du code pour lancer une erreur dans le bloc `do`. Quel type d'erreur faut-il lancer pour qu'elle soit traitée par le premier bloc `catch` ? Puis par le deuxième et par le troisième bloc ?
//:
//: Une autre solution pour traiter les erreurs est d'utiliser `try?` pour convertir le résultat en un optionnel. Si la fonction lance une erreur, la nature de l'erreur est ignorée et le résultat est `nil`. Sinon, le résultat est un optionnel qui contient la valeur retournée par la fonction.
//:
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")


//: Les erreurs sont fréquemment utilisées avec le mot clé `guard`. C'est le cas de la méthode `vend(itemNamed:)` de la classe `VendingMachine` ci-dessous.

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Bertie Bott's Every Flavour Beans": Item(price: 12, count: 7),
        "Chocolate frog": Item(price: 10, count: 0),
        "Jelly slugs": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chocolate frog",
    "Bob": "Bertie Bott's Every Flavour Beans",
    "Eve": "Jelly slugs",
]

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8

for (person, snack) in favoriteSnacks
{
    do {
        print("\(person) tries to buy \(snack)")
        try vendingMachine.vend(itemNamed: snack)
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.outOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    }
}

//: On utilise `defer` pour écrire un bloc de code qui sera executé après tout le code contenu dans la fonction, juste avant qu'elle ne retourne. Ce code s'exécute quoi qu'il arrive (que la fonction lance une erreur ou non). Il joue un rôle semblable au mot clé `finally` en Java mais il n'est pas exclusivement lié à la gestion des erreurs. `defer` peut être utilisé pour écrire le code de mise place (*setup*) et de nettoyage (*cleanup*) à côté l'un de l'autre, même s'ils ont besoin d'être executés à des instants différents.
//:
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}
fridgeContains("banana")
print(fridgeIsOpen)

//: L'usage courant est de fermer les ressources qui ont été ouvertes par la fonction (fichiers, connexions réseau, connexions base de données, ...)
import Foundation

enum AppError : Error {
    case NoSuchFile
}

func processFile(filename: String) throws {
    let filemgr = FileManager.default
    guard filemgr.fileExists(atPath: filename), let file = FileHandle(forReadingAtPath: filename) else {
        throw AppError.NoSuchFile
    }
    defer {
       file.closeFile()
    }
    
    var chunk : Data
    
    repeat {
        chunk = file.readData(ofLength: 128)
        //Do something
    } while chunk.count > 0
        // file.closeFile() is called here, at the end of the scope.
}

do {
    try processFile(filename: "Test")
} catch {
    print(error)
}

//: [Previous](@previous) | [Next](@next)
