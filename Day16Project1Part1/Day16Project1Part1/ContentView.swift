//
//  ContentView.swift
//  Day16Project1Part1
//
//  Created by Ginger on 22/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   @State private var tapCount = 0
   @State private var name = ""
   let students = ["Harry", "Hermione", "Ron"]
   @State private var selectedStudent = "Harry"

   var body: some View {
       Picker("Select your student", selection: $selectedStudent) {
           ForEach(0 ..< students.count) {
               Text(self.students[$0])
           }
       }
       /*
       Form {
           TextField("Enter your name", text: $name)
           Text("Your name is \(name)")
           
           ForEach(0 ..< 100) { number in
               Text("Row \(number)")
           }
       }
*/
       /*
       Button("Tap Count \(tapCount)") {
           self.tapCount += 1
       }
*/
       /*
       NavigationView {
           Form {
               Section {
                   Text("Hello, World!")
               }
           }
           //.navigationBarTitle(Text("SwiftUI"), displayMode: .inline)
           .navigationBarTitle("SwiftUI")
       }
        */
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
