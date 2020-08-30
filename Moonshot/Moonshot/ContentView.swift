//
//  ContentView.swift
//  Moonshot
//
//  Created by Ginger on 30/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingLaunchDate = true
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        //Text("\(astronauts.count)")
        NavigationView {
            List(missions) { mission in
                //NavigationLink(destination: Text("Detail View")) {
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        //.aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if self.showingLaunchDate {
                            Text(mission.formattedLaunchDate)
                        } else {
                            CrewMembersView(mission: mission, astronauts: self.astronauts)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(action: {
                self.showingLaunchDate.toggle()
            }) {
                if self.showingLaunchDate {
                    Text("Show Crew Members")
                } else {
                    Text("Show Launch Date")
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
