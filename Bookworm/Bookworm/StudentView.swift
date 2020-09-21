//
//  ContentView.swift
//  Bookworm
//
//  Created by Ginger on 19/09/2020.
//

import SwiftUI

struct StudentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                
                let chosenFirstname = firstNames.randomElement()!
                let chosenLastname = lastNames.randomElement()!
                
                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = "\(chosenFirstname) \(chosenLastname)"
                
                try? self.moc.save()
            }
        }
        
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView()
    }
}
