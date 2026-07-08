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
    @State private var showCalculation=false
    let arrayTips = [10, 20, 30, 40, 50]
    @State private var selectedTip = 10
    func calculateBill(bill:Double,tip:Double,people:Double) -> Double
    {
        
        var tipSum=(bill*tip)/100
        var finalSum=(bill+tipSum)/people
        return finalSum
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
                        )
                    }
                    
                    Section{
                        Text("Enter the bill value:")
                        TextField(
                            "Type the bill value here:",
                            value: $billValue,
                            format: .currency(
                                code: Locale.current.currency?.identifier ?? "USD"
                            )
                        )
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
                        }
                    }
                }
                
                Button(action: {showCalculation=true})
                    {
                        Text("Start Calculation!")
                    }

                

            }
        }
    }
}

#Preview {
    ContentView()
}
