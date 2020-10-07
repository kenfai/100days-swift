//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Ginger on 06/10/2020.
//

import SwiftUI
import CodeScanner
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

enum SortMethod {
    case byName, byDateAdded
}

struct ProspectsView: View {
    let filter: FilterType
    @State var sortMethod: SortMethod
    
    @EnvironmentObject var prospects: Prospects
    
    @State private var isShowingScanner = false
    @State private var showingActionSheet = false
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var sortedProspects: [Prospect] {
        switch sortMethod {
        case .byName:
            return filteredProspects.sorted(by: { $0.name < $1.name })
        case .byDateAdded:
            return filteredProspects.sorted(by: { $0.dateAdded < $1.dateAdded })
        }
        
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        if filter == .none {
                            Image(systemName: "phone.arrow.right")
                                .foregroundColor(prospect.isContacted ? Color.gray : Color.green)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button(action: {
                self.showingActionSheet = true
            }) {
                Image(systemName: "arrow.up.arrow.down.circle")
                Text("Sort")
            }, trailing: Button(action: {
                // Placeholder
                /*let prospect = Prospect()
                prospect.name = "Paul Hudson"
                prospect.emailAddress = "paul@hackingwithswift.com"
                self.prospects.people.append(prospect)*/
                self.isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Beatrice Mann\nbeatrice@gmail.com", completion: self.handleScan)
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Sort Contacts"), message: Text("Select Sort Method"), buttons: [
                    .default(Text("By Name")) { self.sortMethod = .byName },
                    .default(Text("By Date Added")) { self.sortMethod = .byDateAdded },
                    .cancel()
                ])
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            //self.prospects.people.append(person)
            //self.prospects.save()
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning Failed")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none, sortMethod: .byName)
    }
}
