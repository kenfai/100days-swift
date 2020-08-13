// Day 7: CLOSURES PART 2

// 6. CLOSURES WITH PARAMETER
func travelTo(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travelTo(action: { (place: String) in
    print("I'm going to \(place) in my car")
})

travelTo { (place: String) in
    print("I'm going to \(place) in my car")
}

// 7. CLOSURES WITH RETURN VALUES
func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel(action: { (place: String) in
    return "I'm going to \(place) in my car"
})

travel { (place: String) in
    return "I'm going to \(place) in my car"
}

// Reducer
func reduce(numbers: [Int], using closure: (Int, Int) -> Int) -> Int {
    var first = numbers[0]
    
    for current in numbers[1...] {
        first = closure(first, current)
    }
    
    return first
}

let numbers = [10, 20, 30]

let multiply = reduce(numbers: numbers) { (currentValue: Int, next: Int) -> Int in
    currentValue * next
}
print(multiply)

let sum = reduce(numbers: numbers, using: +)

// 8. SHORTHAND PARAMETER NAMES
travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

travel { (place) -> String in
    return "I'm going to \(place) in my car"
}

travel { place -> String in
    return "I'm going to \(place) in my car"
}

travel { place in
    return "I'm going to \(place) in my car"
}

travel { place in
    "I'm going to \(place) in my car"
}

travel {
    "I'm going to \($0) in my car"
}

// 9. CLOSURES WITH MULTIPLE PARAMETERS

func travelAt(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travelAt {
    "I'm going to \($0) at \($1) miles per hour"
}

travelAt { place, speed in
    "I'm going to \(place) at \(speed) miles per hour"
}

// 10. RETURNING CLOSURES
func travelBack() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result = travelBack()
result("London")

func makeRandomGenerator() -> () -> Int {
    let function = { Int.random(in: 1...10) }
    return function
}

let generator = makeRandomGenerator()
let random1 = generator()
print(random1)

// 11. CAPTURING VALUES

func travelBy() -> (String) -> Void {
    var counter = 1
    
    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

let resultBy = travelBy()
resultBy("London")
resultBy("London")
resultBy("London")

func makeRandomNumberGenerator() -> () -> Int {
    var previousNumber = 0

    return {
        var newNumber: Int
        
        repeat {
            newNumber = Int.random(in: 1...3)
        } while newNumber == previousNumber
        
        previousNumber = newNumber
        return newNumber
    }
}

let generatorUnique = makeRandomNumberGenerator()

for _ in 1...10 {
    print(generatorUnique())
}
