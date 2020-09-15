//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ginger on 15/09/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Button("Create account") {
                print("creating account..")
            }.disabled(disableForm)
        }
    }
    
    var disableForm: Bool {
        username.isEmpty || email.isEmpty
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
