//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Ginger on 22/09/2020.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

enum Predicates: String {
    case equal, inside, beginsWith
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    //@FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    //@FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Star Trek"])) var ships: FetchedResults<Ship>
    //@FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
    
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
    
    @State private var lastNameFilter = "A"
    
    var body: some View {
        /*List {
            ForEach([2, 4, 6, 8, 10], id: \.self) {
                Text("\($0)")
            }
        }
        
        List(students, id: \.self) { student in
            Text(student.name)
        }
        
        Button("Save") {
            if self.moc.hasChanges {
                try? self.moc.save()
            }
        }
        */
        VStack {
            /*List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }*/
            
            /*List(ships, id: \.self) { ship in
                Text("\(ship.name ?? "Unknown name")")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? self.moc.save()
            }*/
            
            // list of matching singers
            //FilteredList(filter: lastNameFilter)
            
            FilteredGenericList(sortDescriptors:[
                NSSortDescriptor(keyPath: \Singer.firstName, ascending: true)
            ], predicate: .beginsWith, filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
                                
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            Button("Show A") {
                self.lastNameFilter = "A"
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
            }
            
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                    let candy2 = Candy(context: moc)
                    candy2.name = "KitKat"
                    candy2.origin = Country(context: moc)
                    candy2.origin?.shortName = "UK"
                    candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
