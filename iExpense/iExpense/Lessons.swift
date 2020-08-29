//
//  Lessons.swift
//  iExpense
//
//  Created by Ginger on 29/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var name: String

    var body: some View {
        //Text("Second View")
        //Text("Hello \(name)")
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct User2: Codable {
    var firstName: String
    var lastName: String
}

struct Lessons: View {
    @ObservedObject private var user = User()
    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    @State private var user2 = User2(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your name is \(user.firstName) \(user.lastName)")
                
                TextField("First name", text: $user.firstName)
                TextField("Last name", text: $user.lastName)
                
                Button("Show Sheet") {
                    // show the sheet
                    self.showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    // contents of the sheet
                    SecondView(name: "Twostraws")
                }
                
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
                
                Button("Tap count: \(tapCount)") {
                    self.tapCount += 1
                    UserDefaults.standard.set(self.tapCount, forKey: "Tap")
                }
                
                Button("Save User") {
                    let encoder = JSONEncoder()
                    
                    if let data = try? encoder.encode(self.user2) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct Lessons_Previews: PreviewProvider {
    static var previews: some View {
        Lessons()
    }
}
