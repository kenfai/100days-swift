//
//  AstronautView.swift
//  Moonshot
//
//  Created by Ginger on 30/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    let missions: [Mission]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                        .frame(width: geometry.size.width)
                        .accessibility(label: Text("Photo of astronaut \(self.astronaut.name)"))
                    
                    Text(self.astronaut.description)
                    .padding()
                    .layoutPriority(1)
                    
                    Text("Missions Involved:")
                        .font(.headline)
                        .padding()
                    
                    ForEach(self.missions, id: \.id) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                //.aspectRatio(contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                                .padding(.leading)
                            
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                            }
                            
                            Spacer()
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        
        for mission in missions {
            if let match = mission.crew.first(where: { $0.name == astronaut.id }) {
                matches.append(mission)
            }
        }
        
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
