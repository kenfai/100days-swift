//
//  CrewMembersView.swift
//  Moonshot
//
//  Created by Ginger on 31/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct CrewMembersView: View {
    let mission: Mission
    let astronauts: [Astronaut]
    
    var members: [Astronaut] {
        var matches = [Astronaut]()
        
        for crew in mission.crew {
            if let match = astronauts.first(where: { $0.id == crew.name }) {
                matches.append(match)
            } else {
                fatalError("Missing \(crew.name)")
            }
        }
        
        return matches
    }
    
    var body: some View {
        ForEach(members, id: \.id) { member in
            Text(member.name)
                .font(.footnote)
        }
    }
}

struct CrewMembersView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        CrewMembersView(mission: missions[0], astronauts: astronauts)
    }
}
