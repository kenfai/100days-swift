//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Ginger on 14/10/2020.
//

import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favourites: Favourites
    
    //@State private var selectedFacility: String?
    @State private var selectedFacility: Facility?
    
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailsView(resort: resort) }
                            VStack { SkiDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    //Text(resort.facilities.joined(separator: ", "))
                    /*Text(ListFormatter.localizedString(byJoining: resort.facilities))
                        .padding(.vertical)*/
                    HStack {
                        /*ForEach(resort.facilities) { facility in
                            Facility.icon(for: facility)
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }*/
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            
            Button(favourites.contains(resort) ? "Remove from Favourites" : "Add to Favourites") {
                if self.favourites.contains(self.resort) {
                    self.favourites.remove(self.resort)
                } else {
                    self.favourites.add(self.resort)
                }
            }
            .padding()
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        .alert(item: $selectedFacility) { facility in
            //Facility.alert(for: facility)
            facility.alert
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
