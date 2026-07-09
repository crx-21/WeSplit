//
//  ContentView.swift
//  WeSplit
//
//  Created by Freak on 08.07.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var showMainApp = false
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        Text("Welcome!")
                        Text("Press Begin to start!")
                    }
                    Section {
                        Button(action: { showMainApp = true }) {
                            Text("Begin!")
                        }
                    }
                }

            }
            .padding()
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showMainApp) {
                MainApp()
            }
        }

    }
}

struct MainApp: View {
    @State private var numberOfPeople=0
    @State private var billValue = 0.0
    @State private var computedCalculation = 0.0
    @FocusState private var isFocused:Bool
    let arrayTips = [10, 20, 30, 40, 50]
    @State private var selectedTip = 10
    var calculateBill: (Double,Double)
    {
        
        var tipSum=(billValue*Double(selectedTip))/100
        var finalSum=(billValue+tipSum)/Double(numberOfPeople)
        return (finalSum,tipSum)
    }
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section{
                        Text("How many people are there at the table:")
                        TextField(
                            "Type the number of people here!",
                            value: $numberOfPeople,format: .number
                               
                        )   .focused($isFocused)
                        .keyboardType(.decimalPad)
                    }
                    
                    Section{
                        Text("Enter the bill value:")
                        TextField(
                            "Type the bill value here:",
                            value: $billValue,
                            format: .currency(
                                code: Locale.current.currency?.identifier ?? "USD"
                            )
                        ).focused($isFocused)
                        .keyboardType(.decimalPad)
                    }
                    
                    Section{
                        Text("How much of a tip do you want to leave?")
                        List {
                            Picker("Tip Value:", selection: $selectedTip) {
                                ForEach(arrayTips, id: \.self) {
                                    Text($0, format: .percent)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    HStack{
                        Section {
                            Text("Result:")
                            Text(calculateBill.0, format: .currency(code: Locale.current.currency?.identifier ?? "RON"))
                                                    }
                        Section{
                            Text("Bill+Tip:")
                            Text(calculateBill.1, format: .currency(code: Locale.current.currency?.identifier ?? "RON"))
                        
                        }
                        
                    }
                    
                }

            }
        }
        .toolbar {
            if isFocused{
                Button("Done")
                {
                    isFocused=false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
