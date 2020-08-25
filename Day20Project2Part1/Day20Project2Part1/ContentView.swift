//
//  ContentView.swift
//  Day20Project2Part1
//
//  Created by Ginger on 23/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        VStack() {
            VStack(spacing: 20) {
                HStack {
                    Text("Hello, World!")
                        .background(Color.secondary)
                    Text("This is")
                    Text("Abcd")
                }
                HStack {
                    Text("Hello, World!")
                    Text("This is")
                    Text("Abcd")
                    Spacer()
                }
                .background(Color.red)
                HStack {
                    Text("Hello, World!")
                    Text("This is")
                    Text("Abcd")
                    .background(Color.red)
                }
            }
            Spacer()
            
            VStack {
                ZStack {
                    Color.red
                    Text("Your content")
                }
                
                ZStack {
                    Color.red.frame(width: 200, height: 200)
                    Text("My content")
                }
            }
            
            VStack {
                Button("Tap me!") {
                    print("Button was tapped!")
                }
                
                Button(action: {
                    print("Button was tapped!")
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "pencil")
                        Text("Edit")
                    }
                }
                
                Button("Show Alert") {
                    self.showingAlert = true
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Hello SwiftUI"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
                }
            }
            
            VStack {
                
                LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
                
                RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
                
                AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
            }
            ZStack {
                Color(red: 1, green: 0.8, blue: 0).edgesIgnoringSafeArea(.all)
                Text("The content")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
