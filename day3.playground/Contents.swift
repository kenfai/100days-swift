// DAY 3

// ARITHMETIC OPERATORS

let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore
let difference = firstScore - secondScore

let product = firstScore * secondScore
let divided = firstScore / secondScore

let remainder = 13 % secondScore
let number = 465
let isMultiple = number.isMultiple(of: 7)

let value: Double = 90000000000000001

// OPERATOR OVERLOADING

let meaningOfLife = 42
let doubleMeaning = 42 + 42

let fakers = "Fakers gonna "
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

// COMPOUND OPERATORS

var score = 95
score -= 5

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"

// COMPARISON OPERATORS

firstScore == secondScore
firstScore != secondScore

firstScore < secondScore
firstScore >= secondScore

"Taylor" <= "Swift"

// CONDITIONS

let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("Aces - lucky!")
} else if (firstCard + secondCard == 21) {
    print("Blackjack!")
} else {
    print("Regular cards")
}

// COMBINING OPERATORS

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}

// THE TERNARY OPERATOR

print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

// SWITCH STATEMENT

let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

// RANGE OPERATORS
switch score {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
case 85...90:
    print("You did excellent!")
default:
    print("You did great!")
}

let names = ["Piper", "Alex", "Suzanne", "Gloria"]

print(names[0])

print(names[1...3])
print(names[...3])
print(names[2...])

