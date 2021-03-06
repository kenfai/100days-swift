//
//  MissionView.swift
//  Moonshot
//
//  Created by Ginger on 30/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let astronauts: [CrewMember]

    let mission: Mission
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geo in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width)
                            .padding(.top, min(10 + geometry.frame(in: .global).minY - geo.frame(in: .global).minY, geo.frame(in: .local).maxY * 0.2))
                            .padding(.bottom, 10)
                            .accessibility(label: Text("Mission Badge of Apollo \(self.mission.id)"))
                        
                        /*Text("geometry global minY \(geometry.frame(in: .global).minY)")
                            .position(x: 50, y: 400)
                            .foregroundColor(Color.red)
                        Text("geo global minY \(geo.frame(in: .global).minY)")
                            .position(x: 50, y: 450)
                            .foregroundColor(Color.red)*/
                    }
                    //.background(Color.blue)
                    
                    VStack {
                        Text("Launch Date:")
                            .font(.caption)
                        Text(self.mission.formattedLaunchDate)
                            .font(.headline)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibility(label: Text("Launch Date: \(self.mission.formattedLaunchDate)"))
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 64)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                    .frame(width: 83, height: 70)
                                    .overlay(Circle().stroke(crewMember.role == "Commander" ? Color.red : Color.blue, lineWidth: 3))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.title)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
    }
}
