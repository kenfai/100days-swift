// DAY 4 - LOOPS

// FOR LOOPS
let count = 1...10

for number in count {
    print("Number is \(number)")
}

let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}

for _ in 1...5 {
    print("Play")
}

for num in 1...5 {
    // Do something
}

// WHILE LOOPS
var number = 1

while number <= 20 {
    print(number)
    number += 1
}

print("Ready or not, here I come!")

// REPEAT LOOPS (DO..WHILE)
number = 1

repeat { // executed at least once
    print(number)
    number += 1
} while number <= 20

print("Ready or not, here I come!")

repeat {
    print("This is false")
} while false

let cards = [1, 2, 3, 4, 5]
var random: [Int]

repeat {
    random = cards.shuffled()
} while random == cards

var countDown = 10

// EXITING LOOPS
while countDown >= 0 {
    print(countDown)
    
    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }
    
    countDown -= 1
}

// EXITING MULTIPLE LOOPS
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) x \(j) = \(product)")
        
        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

// SKIPPING ITEMS
for i in 1...10 {
    if i % 2 == 1 { // if it's odd
        continue
    }
    
    print (i)
}

// INFINITE LOOPS
var minute = 0

while true {
    print(minute)
    minute += 1
    
    if (minute >= 273) {
        break
    }
}
