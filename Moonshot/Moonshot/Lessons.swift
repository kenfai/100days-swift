//
//  Lessons.swift
//  Moonshot
//
//  Created by Ginger on 30/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a CustomText")
        self.text = text
    }
}

struct Lessons: View {
    var body: some View {
       Button("Decode JSON") {
           let input = """
           {
               "name": "Taylor Swift",
               "address": {
                   "street": "555, Taylor Swift Avenue",
                   "city": "Nashville"
               }
           }
           """
           
           struct User: Codable {
               var name: String
               var address: Address
           }
           
           struct Address: Codable {
               var street: String
               var city: String
           }
           
           let data = Data(input.utf8)
           let decoder = JSONDecoder()
           
           if let user = try? decoder.decode(User.self, from: data) {
               print(user.address.street)
           }
       }
       /*
       NavigationView {
           VStack {
               List(0..<100) { row in
                   NavigationLink(destination: Text("Detail \(row)")) {
                       Text("Row \(row)")
                   }
               }
           }
           .navigationBarTitle("SwiftUI")
       }
*/
       /*ScrollView(.vertical) {
           VStack(spacing: 10) {
               ForEach(0..<100) {
                   CustomText("Item \($0)")
                       .font(.title)
               }
           }
           .frame(maxWidth: .infinity)
       }*/
       /*
       VStack {
           GeometryReader{ geo in
               Image("Example")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: geo.size.width)
           }
       }
*/
    }
}

struct Lessons_Previews: PreviewProvider {
    static var previews: some View {
        Lessons()
    }
}
