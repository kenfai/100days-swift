//
//  ContentView.swift
//  BetterRest
//
//  Created by Ginger on 25/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    //@State private var alertTitle = ""
    //@State private var alertMessage = ""
    //@State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("When do you want to wake up?")) {
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    
                    Section(header: Text("Desired amount of sleep")) {
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                        .accessibility(value: Text("\(sleepAmount, specifier: "%g") hours"))
                    }
                    
                    Section (header: Text("Daily coffee intake")) {
                        Picker(selection: $coffeeAmount, label: Text("Select a value")) {
                            ForEach(0 ..< 20) {
                                Text("\($0 + 1) cups")
                            }
                        }
                        /*
                        Stepper(value: $coffeeAmount, in: 0...20) {
                            if coffeeAmount == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(coffeeAmount) cups")
                            }
                        }
     */
                    }
                }
                .navigationBarTitle("BetterRest")
                /*.navigationBarItems(trailing: Button(action: calculateBedtime) {
                    Text("Calculate")
                })
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }*/
                Text("Your ideal bedtime")
                    .font(.headline)
                Text("\(suggestedBedtime)")
                    .font(.system(size: 64))
                    .padding(.bottom, 140)
            }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    //func calculateBedtime() {
    var suggestedBedtime: String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        do {
            let prediction = try
            model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
            //alertTitle = "Your ideal bedtime is..."
        } catch {
            //alertTitle = "Error"
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
