// ARRAYS
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles: [String] = [john, paul, george, ringo]

beatles[1]
//beatles[5] // Error

// SETS
let colors = Set<String>(["red", "green", "blue"])
// no duplicates
let colors2 = Set(["red", "green", "blue", "red", "blue"])

// TUPLES
var name = (first: "Taylor", last: "Swift", age: 25)
name.0
name.first
//name.last = 25 // Error
name.last = "Wall"
name.last
name.age

var students = ("Aristotle", "Plato", "Pythagores")
students.1

// DICTIONARIES
let heights: [String: Double] = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
heights["Ed Sheeran"]
heights["Michael Jordan"]

// Default
let favouriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]
favouriteIceCream["Paul"]
favouriteIceCream["Charlotte"]
favouriteIceCream["Charlotte", default: "Unknown!"]

// CREATING EMPTY COLLECITONS
// Empty Dictionary
var teams = [String: String]()
teams["Paul"] = "red"
var scores = Dictionary<String, Int>()
scores["Bull"] = 35

// Empty Array
var results = [Int]()
results.append(50)
var results2 = Array<Int>()

// Empty Sets
var words = Set<String>()
var numbers = Set<Int>()
words.insert("Win")
words

// ENUMERATIONS
enum Result {
    case success
    case failure
}

let result = Result.success

// Associated values
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int, song: String)
}

let talking = Activity.talking(topic: "football")
let singing = Activity.singing(volume: 30, song: "Down the River Stream")

// Raw value
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 3)
