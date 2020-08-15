// DAY 8: STRUCTS

// 1. CREATING STRUCTS
struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)

tennis.name = "Lawn tennis"

// 2. COMPUTED PROPERTIES
struct OSport {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = OSport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

var yes: String {
    "Wow"
}
print(yes)

// 3. PROPERTY OBSERVERS
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
        // willSet to take action before a property changes
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

// 4. METHODS
struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

// 5. MUTATING METHODS
struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
print(person.name)
person.makeAnonymous()
print(person.name)

// 6. PROPERTIES AND METHODS OF STRINGS
let string = "语：Do or do not, there is no try.😔"

print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())

// 7. PROPERTIES AND METHODS OF ARRAYS
var toys = ["Woody"]

print(toys.count)

toys.append("Buzz")

toys.firstIndex(of: "Buzz")

print(toys.sorted())

toys.remove(at: 0)

toys.insert("Mr. Potato", at: 1)

// Experiment
struct Alphabet {
    let many: Int
    let upper = 16
}
var letters = Alphabet(many: 26)
letters.upper
