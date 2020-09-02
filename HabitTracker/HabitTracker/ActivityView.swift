//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Ginger on 02/09/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activities: Activities
    var activity: Activity

    var body: some View {
        VStack {
            Text(activity.title)
                .font(.largeTitle)
                .padding(.vertical)
            
            Text("Completed \(activity.completionCount) times.")
                .padding()
            
            Button(action: {
                self.increaseCount()
            }) {
                Text("Add Count")
            }
            
            Text(activity.description)
                .layoutPriority(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Spacer()
        }
        .navigationBarTitle(Text("Activity Details"), displayMode: .inline)
    }
    
    func increaseCount() {
        if let index = activities.items.firstIndex(where: { $0.id == activity.id }) {
            activities.items[index].completionCount += 1
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activities: Activities(), activity: Activity(title: "Running", description: "Run at least 5km"))
    }
}
