// DAY 15: SWIFT REVIEW - PART 3
import UIKit

// 1. PROPERTIES
struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        
        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

taylor.describe()
other.describe()

// Property observers
taylor.clothes = "short skirts"

// Computed properties
struct Person2 {
    var age: Int
    
    var ageInDogYears: Int {
        //get { // can omit if only get
            return age * 7
        //}
    }
}

var fan = Person2(age: 25)
print(fan.ageInDogYears)

// 2. STATIC PROPERTIES AND METHODS
struct TaylorFan {
    static var favouriteSong = "Look What You Made Me Do"
    
    var name: String
    var age: Int
}

let taylorFan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favouriteSong)

// 3. ACCESS CONTROL
class TaylorBigFan {
    private var name: String?
    fileprivate var age: Int?
}

// 4. POLYMORPHISM AND TYPECASTING
class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}

// Converting types with typecasting
for album in allAlbums {
    print(album.getPerformance())

    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}

var allAlbums2: [Album] = [taylorSwift, fearless]

for album in allAlbums2 {
    let studioAlbum = album as! StudioAlbum
    print(studioAlbum.studio)
}

for album in allAlbums2 as! [StudioAlbum] {
    print(album.studio)
}

for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
    print("yy")
    print(album.location)
}

// Converting common types with initializers
let number = 5
//let text = number as! String // fail

let text = String(number)
text
let n = Int(text)

// 5. CLOSURES
let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})

// Trailing Closures
UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}

// 6. PROTOCOLS
protocol Employee {
    var name: String { get set }
    var jobTitle: String { get set }
    func doWork()
}

struct Executive: Employee {
    var name = "Steve Jobs"
    var jobTitle = "CEO"
    
    func doWork() {
        print("I'm strategizing!")
    }
}

struct Manager: Employee {
    var name = "Maurice Moss"
    var jobTitle = "Head of IT"
    
    func doWork() {
        print("I'm turning it off and on again.")
    }
}

let staff: [Employee] = [Executive(), Manager()]

for person in staff {
    person.doWork()
}

// 7. EXTENSIONS
var myInt = 0

extension Int {
    func addOne() -> Int {
        return self + 1
    }
}

myInt.addOne()
5.addOne()
myInt

extension Int {
    mutating func plusOne() {
        self += 1
    }
}

var myNum = 10
myNum.plusOne()

let otherInt = 10
//otherInt.plusOne() // fail

extension String {
    mutating func trim() {
        self = trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// 8 PROTOCOL EXTENSIONS
extension Int {
    func clamp(low: Int, high: Int) -> Int {
        if (self > high) {
            // if we are higher than the upper bound, return the upper bound
            return high
        } else if (self < low) {
            // if we are lower than the lower bound, return the lower bound
            return low
        }
        
        // we are inside the range, so return our value
        return self
    }
}

let i: Int = 8
print(i.clamp(low: 0, high: 5))

extension BinaryInteger {
    func clamp(low: Self, high: Self) -> Self {
        if (self > high) {
            return high
        } else if (self < low) {
            return low
        }
        
        return self
    }
}

extension Employee {
    func doWork() {
        print("I'm busy!")
    }
}
