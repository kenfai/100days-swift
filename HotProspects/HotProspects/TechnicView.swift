//
//  TechnicView.swift
//  HotProspects
//
//  Created by Ginger on 05/10/2020.
//

import SwiftUI
import UserNotifications
import SamplePackage

class DelayedUpdater: ObservableObject {
    //@Published var value = 0
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct TechnicView: View {
    @State private var selectedTab = "first"
    @State private var backgroundColor = Color.red
    
    @ObservedObject var updater = DelayedUpdater()
    
    let user = User()
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        VStack {
            Text(results)
            
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It Looks hunger"
                content.sound = UNNotificationSound.default
                
                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
            
            Text("Hello World")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                        Text("Red")
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                        Text("Green")
                    }
                    
                    Button(action: {
                        self.backgroundColor = .blue
                    }) {
                        Text("Blue")
                    }
                    
                    Text("What")
                    Image(systemName: "plus")
                }
            
            Image("example")
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
            
            Text("value is \(updater.value)")
            
            Text("Apple")
                .onAppear {
                    self.fetchData(from: "https://www.apple.com") { result in
                        switch result {
                        case .success(let str):
                            print(str)
                        case .failure(let error):
                            switch error {
                            case .badURL:
                                print("Bad URL!")
                            case .requestFailed:
                                print("Network PRoblems")
                            case .unknown:
                                print("Unknown error")
                            }
                        }
                    }
                }
            
            TabView(selection: $selectedTab) {
                Text("Tab 1")
                    .onTapGesture {
                        self.selectedTab = "second"
                    }
                    .tabItem {
                        Image(systemName: "star")
                        Text("One")
                    }
                    .tag("first")
                
                Text("Tab 2")
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Two")
                    }
                    .tag("second")
            }
            
            //EditView()//.environmentObject(user)
            //DisplayView()//.environmentObject(user)
        }.environmentObject(user)
    }
    
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        // check the URL is OK, otherwise return with a failure
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // the task has completed – push our work back to the main thread
            DispatchQueue.main.async {
                if let data = data {
                    // success: convert the data to a string and send it back
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    // any sort of network failure
                    completion(.failure(.requestFailed))
                } else {
                    // this ought not to be possible, yet here we are
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct TechnicView_Previews: PreviewProvider {
    static var previews: some View {
        TechnicView()
    }
}
