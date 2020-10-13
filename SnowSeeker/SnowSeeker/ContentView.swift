//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ginger on 13/10/2020.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var selectedUser: User? = nil
    @State private var layoutVertically = false
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
        
        /*Group {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
        .onTapGesture {
            self.layoutVertically.toggle()
        }*/
        
        /*Text("Hello, world!")
            .onTapGesture {
                self.selectedUser = User()
            }
            .alert(item: $selectedUser) { user in
                Alert(title: Text(user.id))
            }*/
        
        /*NavigationView {
            NavigationLink(destination: Text("New Secondary")) {
                Text("Hello, world!")
            }
            .navigationBarTitle("Primary")
            
            Text("Secondary")
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
