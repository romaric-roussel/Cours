import Foundation

public let 🐮 = "🐮", 🍠 = "🍠", 🐔 = "🐔", 🌽 = "🌽"
public let 🍔 = "🍔", 🍟 = "🍟", 🍗 = "🍗", 🍿 = "🍿"

public func cook(c: String) -> String {
    var s: String = ""
    
    switch c {
    case "🐮": s = "🍔"
    case "🍠": s = "🍟"
    case "🐔": s = "🍗"
    case "🌽": s = "🍿"
    default: s = ""
    }
    return s
}

public func isVegetarian(c: String) -> Bool {
    var res: Bool
    
    switch c {
    case "🍔","🍗": res = false
    default: res = true
    }
    return res
}


public func eat(s: String, o: String) -> String {
    return "💩"
}
