// DAY 9: STRUCT - PART 2

// 8. INITIALIZERS
struct User {
    var username: String
    var age: Int
    
    init() {
        username = "Anonymous"
        age = 1
        print("Creating a new user!")
    }
}

var user = User()
user.username
user.username = "twostraws"

// 9. SELF
struct NamePerson {
    var name: String
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

var man = NamePerson(name: "John")
man.name

// 10. LAZY PROPERTIES
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct FamilyMan {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var ed = FamilyMan(name: "Ed")
ed.familyTree

// 11. STATIC PROPERTIES AND METHODS
struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let harry = Student(name: "Harry")
let taylor = Student(name: "Taylor")

print(Student.classSize)

// 12. ACCESS CONTROL (PRIVATE)
struct Citizen {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let joe = Citizen(id: "ABCD1234")
//joe.id

