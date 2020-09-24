//
//  ContentView.swift
//  FriendFace
//
//  Created by Ginger on 23/09/2020.
//

import SwiftUI

/*struct User: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}

struct Friend: Codable {
    var id: String
    var name: String
}*/

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            VStack {
                List(users, id:\.id) { user in
                    NavigationLink(destination: UserView(user: user)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(user.wrappedName)")
                                    .font(.headline)
                                Text("Age: \(user.age)")
                            }
                            
                            Spacer()
                            
                            Image(systemName: "circle.fill")
                                .foregroundColor(user.isActive ? .green : .red)
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        self.users = decodedResponse
                    }
                    
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
