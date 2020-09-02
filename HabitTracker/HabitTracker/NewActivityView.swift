//
//  NewActivityView.swift
//  HabitTracker
//
//  Created by Ginger on 02/09/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct NewActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
            }
            .navigationBarTitle(Text("Add New Activity"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button(action: {
                    self.activities.items.append(Activity(title: self.title, description: self.description))
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add")
            })
        }
    }
}

struct NewActivityView_Previews: PreviewProvider {
    static var previews: some View {
        NewActivityView(activities: Activities())
    }
}
