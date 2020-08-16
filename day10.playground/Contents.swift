// DAY 10: CLASSES

// 1. CREATING CLASSES
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

// 2. CLASS INHERITANCE
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

let mango = Poodle(name: "Mango")

// 3. OVERRIDING METHODS
class BarkDog {
    func makeNoise() {
        print("Woof!")
    }
}

class SmallPoodle: BarkDog {
    override func makeNoise() {
        print("Yip!")
    }
}

let small = SmallPoodle()
small.makeNoise()

// 4. FINAL CLASSES
final class Canine {
    // final class cannot be inherited
}

//class K9: Canine {}

// 5. COPYING OBJECTS
class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var dancer = Singer()
var singerCopy = singer

singerCopy.name = "Justin Bieber"

print(dancer.name)
print(singer.name)
print(singerCopy.name)

// 6. DEINITIALIZERS
class Person {
    var name = "John Doe"
    
    init() {
        print("\(name) is alive!")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

// 7. MUTABILITY
let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)

