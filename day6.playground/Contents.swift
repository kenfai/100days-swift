// Day 6: CLOSURES PART 1

// 1. BASIC CLOSURES
let driving = {
    print("I'm driving in my car")
}

driving()

// 2. ACCEPTING PARAMETERS
let drivingTo = { (place: String) in
    print("I'm going to \(place) in my car")
}

drivingTo("London")

// 3. RETURNING VALUES
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)

// empty parameter
let payment = { () -> Bool in
    print("Paying an anonymous person")
    return true
}
payment()

let driveSafely = {
    return "I'm being a considerate driver"
}
print(driveSafely())

// 4. CLOSURES AS PARAMETERS
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving)

// 5. TRAILING CLOSURE SYNTAX
travel() {
    print("I'm driving in my car")
}

// since there's no parameter, can omit ()
travel {
    print("I'm driving in my car")
}

func animate(duration: Double, animations: () -> Void) {
    print("Starting a \(duration) seconds animation..")
    animations()
}

// without trailing closure
animate(duration: 3, animations: {
    print("Fade out the image")
})

// using trailing closure
animate(duration: 5) {
    print("Fade in the image")
}
