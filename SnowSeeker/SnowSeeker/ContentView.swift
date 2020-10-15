//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ginger on 13/10/2020.
//

import SwiftUI

enum SortMethod {
    case none, alphabetical, country
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct ContentView: View {
    @ObservedObject var favourites = Favourites()
    
    @State private var showingActionSheet = false
    @State private var showingSheet = false
    @State private var selectedCountry = 0
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var countries = ["All", "Austria", "Canada", "France", "Italy", "United States"]
    @State private var filterSize = 0
    @State private var filterPrice = 0
    
    @State private var sortMethod: SortMethod = .alphabetical
    
    var filteredSortedResorts: [Resort] {
        var filteredResorts = resorts
        
        if selectedCountry != 0 {
            filteredResorts = filteredResorts.filter { $0.country == countries[selectedCountry] }
            print(selectedCountry)
        }
        if filterSize != 0 {
            filteredResorts = filteredResorts.filter { $0.size == filterSize }
        }
        if filterPrice != 0 {
            filteredResorts = filteredResorts.filter { $0.price == filterPrice }
        }

        switch sortMethod {
        case .alphabetical:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        default:
            return filteredResorts
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredSortedResorts) { resort in
                    NavigationLink(destination: ResortView(resort: resort)) {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        .layoutPriority(1)
                        
                        if self.favourites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibility(label: Text("This is a favourite resort"))
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    self.showingActionSheet = true
                }) {
                    Text("Sort")
                    Image(systemName: "arrow.up.arrow.down.circle")
                }
                
                Button(action: {
                    self.showingSheet = true
                }) {
                    Text("Filter")
                    Image(systemName: "line.horizontal.3.decrease.circle")
                }
                
            })
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Sort"), message: Text("Select a sorting method"), buttons: [
                    .default(Text("Default")) {
                        self.sortMethod = .none
                    },
                    .default(Text("Alphabetical")) {
                        self.sortMethod = .alphabetical
                        
                    },
                    .default(Text("Country")) {
                        self.sortMethod = .country
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: $showingSheet) {
                Form {
                    Picker(selection: $selectedCountry, label: Text("Country")) {
                        ForEach(0 ..< self.countries.count) {
                            Text(self.countries[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Stepper("Size: \(filterSize == 0 ? "Any" : "\(filterSize)")", value: $filterSize, in: 0...3)
                    Stepper("Price: \(filterPrice == 0 ? "Any" : "\(filterPrice)")", value: $filterPrice, in: 0...3)
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favourites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
