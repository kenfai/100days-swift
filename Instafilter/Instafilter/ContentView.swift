//
//  ContentView.swift
//  Instafilter
//
//  Created by Ginger on 24/09/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello, world!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change Background"), message: Text("Select a new colour"), buttons: [
                    .default(Text("Red")) { self.backgroundColor = .red },
                    .default(Text("Green")) { self.backgroundColor = .green },
                    .default(Text("Blue")) { self.backgroundColor = .blue },
                    .cancel()
                ])
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
