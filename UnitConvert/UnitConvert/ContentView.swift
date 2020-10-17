//
//  ContentView.swift
//  UnitConvert
//
//  Created by Ginger on 23/08/2020.
//  Copyright © 2020 Ginger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var input = ""
    @State private var unitFrom = 0
    @State private var unitTo = 0
    
    let units = ["metre", "kilometre", "feet", "yard", "mile"]
    
    var result: Double {
        let inputValue = Double(input) ?? 0
        
        var baseValue = inputValue
        
        switch unitFrom {
        case 1:
            baseValue = inputValue * 1000
        case 2:
            baseValue = inputValue * 0.3048
        case 3:
            baseValue = inputValue * 0.9144
        case 4:
            baseValue = inputValue * 1609.344
        default:
            baseValue = inputValue * 1
        }
        
        var convertedValue = baseValue
        
        switch unitTo {
        case 1:
            convertedValue = baseValue / 1000
        case 2:
            convertedValue = baseValue / 0.3048
        case 3:
            convertedValue = baseValue / 0.9144
        case 4:
            convertedValue = baseValue / 1609.344
        default:
            convertedValue = baseValue / 1
        }
        
        return convertedValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("#100DaysOfSwift Day 19: Challenge")) {
                    TextField("Enter value", text: $input)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Select Unit to Convert From")) {
                    Picker("Convert From Unit", selection: $unitFrom) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select Unit to Convert To")) {
                    Picker("Convert To Unit", selection: $unitTo) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text("\(result, specifier: "%.4f") \(self.units[unitTo])")
                }
            }
            .navigationBarTitle(Text("ConvertMe"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
