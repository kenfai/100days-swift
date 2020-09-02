//
//  ContentView.swift
//  HabitTracker
//
//  Created by Ginger on 02/09/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities = Activities()
    @State private var showingAddNew = false

    var body: some View {
        NavigationView {
            List {
                ForEach(self.activities.items, id:\.id) { item in
                    NavigationLink(destination: ActivityView(activities: self.activities, activity: item)) {
                        Text("\(item.title) (Completed: \(item.completionCount))")
                    }
                }
            .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddNew.toggle()
            }) {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingAddNew) {
            NewActivityView(activities: self.activities)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
