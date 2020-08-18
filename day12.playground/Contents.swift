// DAY 12: OPTIONALS

// 1. HANDLING MISSING DATA
var age: Int? = nil
age = 38

// 2. UNWRAPPING OPTIONALS
var name: String? = nil
let un = name
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

// 3. UNWRAPPING WITH GUARD
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("Hello, \(unwrapped)!")
}

// 4. FORCE UNWRAPPING
let str = "5"
let num = Int(str)!

// 5. IMPLICITLY UNWRAPPED OPTIONALS
let year: Int! = nil

// 6. NIL COALESCING
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous"

// Chaining
func first() -> String? {
    "Player 1"
}
func second() -> String?  {
    "Player 2"
}
let player = first() ?? second() ?? "on-hold"

// Dictionaries always return optionals
let scores = ["Picard": 800, "Data": 7000, "Troi": 900]
let crusherScore = scores["Crusher"] ?? 0

// 7. OPTIONAL CHAINING
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()

let artists = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
let surnameLetter = artists["Vincent"]?.first?.uppercased() ?? "?"

// 8. OPTIONAL TRY
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

try! checkPassword("sekrit")
print("OK")

// 9. FAILABLE INITIALIZERS
struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

let person = Person(id: "1234")

struct Employee {
    var username: String
    var password: String
    
    init?(username: String, password: String) {
        guard password.count >= 8 else { return nil }
        guard password.lowercased() != "password" else { return nil }
        
        self.username = username
        self.password = password
    }
}

let tim = Employee(username: "TimC", password: "app1e")
let craig = Employee(username: "CraigF", password: "longpassword")

// 10. TYPECASTING
class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

let dog = pets[0]
dog as? Fish

let menu: [String?]? = [nil, nil]

let album = "Red"
let albums = ["Reputation", "Red", "1989"]
let g = albums.firstIndex(of: "a")
if let position = albums.firstIndex(of: album) {
    print("Found \(album) at position \(position).")
}
