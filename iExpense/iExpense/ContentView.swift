//
//  ContentView.swift
//  iExpense
//
//  Created by Ginger on 29/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack (alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("\(item.amount)")
                    }
                    
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
                    //let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    //self.expenses.items.append(expense)
                    print(self.showingAddExpense)
                    self.showingAddExpense = true
                    print(self.showingAddExpense)
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
