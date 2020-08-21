// DAY 14: SWIFT REVIEW PART 2
import UIKit


// 1. FUNCTIONS
func favouriteAlbum() {
    print("My favourite is Fearless")
}

favouriteAlbum()

func myFavouriteAlbum(name: String) {
    print("My favourite is \(name)")
}

myFavouriteAlbum(name: "Fearless")

func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year)")
}

printAlbumRelease(name: "Fearless", year: 2008)
printAlbumRelease(name: "Speak Now", year: 2010)
printAlbumRelease(name: "Red", year: 2012)

// External and internal parameter names
func countLettersInString(myString str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString(myString: "Hello")

func countString(_ str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countString("Hello")

func countLetters(in string: String) {
    print("The string \(string) has \(string.count) letters.")
}

countLetters(in: "Hello")

// Return values
func albumIsTaylor(name: String) -> Bool {
    if name == "Taylor Swift" { return true }
    if name == "Fearless" { return true }
    if name == "Speak Now" { return true }
    
    return false
}

if albumIsTaylor(name: "Fearless") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}

if albumIsTaylor(name: "Blue") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}

// 2. OPTIONALS
func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

var status: String?
status = getHaterStatus(weather: "rainy")

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

if let haterStatus = getHaterStatus(weather: "rainy") {
    takeHaterAction(status: haterStatus)
}

// Force unwrapping optionals
func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }
    
    return nil
}

var year = yearAlbumReleased(name: "Red")

if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year!)")
}

// Implicitly unwrapped optionals
let g: String! = nil

// 3. OPTIONAL CHAINING
func albumReleased(year: Int) -> String? {
    switch year {
    case 2006:
        return "Taylor Swift"
    case 2008:
        return "Fearless"
    case 2010:
        return "Speak Now"
    case 2012:
        return "Red"
    case 2014:
        return "1989"
    default:
        return nil
    }
}

let album = albumReleased(year: 2006)?.uppercased()
print("The album is \(album)")

// The nil coalescing operator
let album2 = albumReleased(year: 2006) ?? "unknown"
print("The album is \(album2)")

// 4. ENUMERATIONS
enum WeatherType {
    case sun
    case cloud
    case rain
    case wind
    case snow
}
func getHaterStatus2(weather: WeatherType) -> String? {
    if weather == .sun {
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus2(weather: .cloud)

func getHaterStatus3(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .cloud, .wind, .snow:
        return "dislike"
    case .rain:
        return "hate"
    }
}

getHaterStatus3(weather: .snow)

// Enums with addtional values
enum WeatherType2 {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

func getHaterStatus4(weather: WeatherType2) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus4(weather: .wind(speed: 5))

// 5. STRUCTS
struct Person {
    var clothes: String
    var shoes: String
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

var taylorCopy = taylor
taylorCopy.shoes = "flip flops"

print(taylor.clothes)
print(other.shoes)
print(taylor)
print(taylorCopy)

// Functions inside structs
struct Person2 {
    var clothes: String
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

// 6. CLASSES
// Initializing an object
class Person3 {
    var clothes: String
    var shoes: String
    var acc: String?
    
    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
}
let me = Person3(clothes: "tshirt", shoes: "dockers")
print(me.shoes)

// Class inheritance
class Singer {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func sing() {
        print("La la la la")
    }
}
var taylor2 = Singer(name: "Taylor", age: 25)
taylor2.name
taylor2.age
taylor2.sing()

class CountrySinger: Singer {
    override func sing() {
        print("Trucks, guitars, and liquor")
    }
}

var taylor3 = CountrySinger(name: "Taylor", age: 25)
taylor3.name
taylor3.age
taylor3.sing()

class HeavyMetalSinger: Singer {
    var noiseLevel: Int
    
    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)
    }
    
    override func sing() {
        print("Grrrrr rargh ragh rarrrrrgh!")
    }
}
