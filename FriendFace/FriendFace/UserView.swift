//
//  UserView.swift
//  FriendFace
//
//  Created by Ginger on 23/09/2020.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    @State private var friends = [User]()
    
    var registeredOn: Date {
        let formatter = ISO8601DateFormatter()
        let datetime = formatter.date(from: self.user.wrappedRegistered)
        return datetime!
    }
    
    var body: some View {
        VStack {
            Section {
                Text("\(user.wrappedName)")
                    .font(.largeTitle)
                
                Text("(\(user.age))")
                    .font(.title2)
                
                Text("\(user.wrappedCompany)")
                    .font(.title)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "envelope")
                        Text("\(user.wrappedEmail)")
                    }
                    
                    HStack {
                        Image(systemName: "signpost.left")
                        Text("\(user.wrappedAddress)")
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("About Me")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(user.wrappedAbout)")
                }
                .padding()
                
                Text("Registered on: \(self.registeredOn)")
                    .foregroundColor(.gray)
            }
            
            Section {
                Text("Friends")
                    .fontWeight(.bold)
                /*List(friends, id: \.id) { user in
                    NavigationLink(destination: UserView(user: user)) {
                        Text("\(user.name)")
                    }
                }*/
            }
            
            Spacer()
        }
        .onAppear(perform: loadUser)
    }
    
    func loadUser() {
        var users = [User]()
        
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
                        users = decodedResponse
                        /*for friend in self.user.friends {
                            if let position = users.firstIndex(where: { $0.id == friend.id }) {
                                let userSelected = users[position]
                                self.friends.append(userSelected)
                            }
                        }*/
                    }
                    
                    
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct UserView_Previews: PreviewProvider {
    /*static let user = User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: true, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n", registered: "2015-11-10T01:47:18-00:00", tags: [
        "cillum",
        "consequat",
        "deserunt",
        "nostrud",
        "eiusmod",
        "minim",
        "tempor"
    ], friends: [
        Friend(
            id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0",
            name: "Hawkins Patel"
        ),
        Friend(
            id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6",
            name: "Jewel Sexton"
        )
    ])*/
    static let user = User()
    static var previews: some View {
        UserView(user: user)
    }
}
