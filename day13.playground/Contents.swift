// DAY 13: SWIFT REVIEW 1
import UIKit

// 1. VARABLES AND CONSTANTS
var name = "Time McGraw"
name = "Romeo"

// 2. TYPES OF DATA
var name2: String
name2 = "Tim McGraw"

var age: Int
age = 25

var latitude: Double
latitude = 36.166667

var longitude: Double
longitude = -86.783333

longitude = -186.783333
longitude = -1286.783333
longitude = -12386.783333
longitude = -123486.783333
longitude = -1234121211212586.783333

var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

var missABeat: Bool
missABeat = false

var altitude = -86.545645
var myName: String = "Tim McGraw"

// 3. OPERATORS
var a = 10
a = a + 1
a = a - 1
a = a * a
a = a / a
a = a % a

var b = 10
b += 10
b -= 10

var d = 1.1
var e = 2.2
var f = d + e

var name3 = "Tim McGraw"
var name4 = "Romeo"
var both = name3 + " and " + name4

// Comparison operators
f > 3
f >= 3
f > 4
f < 4

var name5 = "Tim McGraw"
name5 == "Tim McGraw"
name5 != "Tim McGraw"

var stayOutLate = true
stayOutLate
!stayOutLate

// 4. String Interpolation
var name6 = "Tim McGraw"
var age2 = 25
var height = 36.156667
"Your name is \(name6), your age is \(age2), your height is \(height)"

"You are \(age2) years old. In another \(age2) years, you will be \(age2 * 2)."

// 5. ARRAYS
var evenNumbers = [2, 4, 6, 8]
var songs: [String] = ["Shake it Off", "You belong with me", "Back to December"]

songs[0]
songs[1]
songs[2]

type(of: songs)

var moreSongs: [Any] = ["Shake it Off", 3]

// Creating arrays
var mySongs: [String] = []
//mySongs[0] = "Shake it Off"

// Array Operators
var both2 = songs + mySongs
both2 += ["Everything has Changed"]

// 6. DICTIONARIES
var person = [
    "first": "Taylor",
    "middle": "Alison",
    "last": "Swift",
    "month": "December",
    "website": "taylorswift.com"
]

person["middle"]
person["month"]

// 7. CONDITIONAL STATEMENTS
var action: String
var guy = "hater"

if guy == "hater" {
    action = "hate"
} else if guy == "player" {
    action = "play"
} else {
    action = "cruise"
}

// Evaluating multiple conditions
var action2: String
var stayOutLateAgain = true
var nothingThinking = true

if stayOutLateAgain && nothingThinking {
    action2 = "cruise"
}

if !stayOutLateAgain && !nothingThinking {
    action2 = "cruise"
}

// 8. LOOPS
print("1 x 10 is \(1 * 10)")
print("2 x 10 is \(2 * 10)")
print("3 x 10 is \(3 * 10)")
print("4 x 10 is \(4 * 10)")
print("5 x 10 is \(5 * 10)")

for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

var str = "Fakers gonna"

for _ in 1...5 {
    str += " fake"
}

print(str)

// Looping over arrays
for song in songs {
    print("My favourite song is \(song)")
}

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]

for i in 0 ... 3 {
    print("\(people[i]) gonna \(actions[i])")
}

// Inner loops
for i in 0 ..< people.count {
    var str = "\(people[i]) gonna"
    
    for _ in 1 ... 5 {
        str += " \(actions[i])"
    }
    
    print(str)
}

// While loops
var counter = 0

while true {
    print("Counter is now \(counter)")
    counter += 1
    
    if counter == 22 {
        break
    }
}

for song in songs {
    if song == "You belong with me" {
        continue
    }
    
    print("My Favourite song is \(song)")
}

// 9 SWITCH CASE
let liveAlbums = 2

switch liveAlbums {
case 0:
    print("You're just starting out")
    
case 1:
    print("You just released iTunes Live From SoHo")
    
case 2:
    print("You just released Speak Now World Tour")
    
default:
    print("Have you done something new?")
}

let studioAlbums = 5

switch studioAlbums {
case 0...1:
    print("You're just starting out")
    
case 2...3:
    print("You're a rising star")

case 4...5:
    print("You're world famous!")
    fallthrough
default:
    print("Have you done something new?")
}
