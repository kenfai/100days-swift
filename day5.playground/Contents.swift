// DAY 5: FUNCTIONS

// 1. WRITING FUNCTIONS
func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
    print (message)
}

printHelp()

// 2. ACCEPTING PARAMETERS
func square(number: Int) {
    print(number * number)
}

square(number: 8)

// 3. RETURNING VALUES
func square2(number: Int) -> Int {
    return number * number
}

let result = square2(number: 8)
print(result)

// Without 'return' keyword
func doMoreMath() -> Int {
    5 + 5 // expression
}
doMoreMath()

func greet(name: String) -> String {
    name == "Taylor Swift" ? "Oh wow!" : "Hello, \(name)"
}
greet(name: "Taylor Swift")

// Returning two values and above
// i) Array
func getUserArr() -> [String] {
    ["Taylor", "Swift"]
}
let userA = getUserArr()
print(userA[0])
// ii) Dictionary
func getUserDict() -> [String: String] {
    ["first": "Taylor", "last": "Swift"]
}
let userB = getUserDict()
print(userB["first"])
// iii) Tuple
func getUserTuple() -> (first: String, last: String) {
    (first: "Taylor", last: "Swift")
}
let userC = getUserTuple()
print(userC.first)

// 4. PARAMETER LABELS
func sayHello(to name: String) {
    print("Hello, \(name)!")
}
sayHello(to: "Taylor")

// 5. OMITTING PARAMETER LABELS
func greetings(_ person: String) {
    print("Hello, \(person)!")
}
greetings("Taylor")

// 6. DEFAULT PARAMETERS
func greetNicely(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}
greetNicely("Taylor")
greetNicely("Taylor", nicely: false)

// 7. VARIADIC FUNCTIONS
print("Haters", "gonna", "hate")

func squareAny(numbers: Int...) {
    for number in numbers {
        print("\(number) square is \(number * number)")
    }
}
squareAny(numbers: 1, 2, 3, 4, 5)

// 8. WRITING THROWING FUNCTIONS
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

// 9. RUNNING THROWING FUNCTIONS
do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

// 10. INOUT PARAMETERS
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)
