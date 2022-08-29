//
//  ContentView.swift
//  WeSplit
//
//  Created by Aeriel Denmark on 8/26/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 15
    
    @FocusState private var amountIsFocused: Bool
    
    var totalCheckAmount: Double {
        let valueOfTip = Double(tipPercentage) / 100 * checkAmount
        return checkAmount + valueOfTip
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return totalCheckAmount / peopleCount
    }
    
    let tipPercentages = [0, 10, 15, 20, 25]
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format: localCurrency
                        )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    } header: {
                        Text("Initial Check Amount (Pre-Tip)")
                    }
                    
                    Section {
                        Picker("Number of People", selection: $numberOfPeople) {
                            ForEach(2..<11) { number in
                                Text("\(number) people")
                            }
                        }
                    } header: {
                        Text("Party Split")
                    }
                    
                    Section {
                        Picker("Tip", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) { percentage in
                                Text(percentage, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Tip Percentage")
                    }
                    
                    Section {
                        Text(totalCheckAmount, format: localCurrency)
                            .foregroundColor(tipPercentage == 0 ? .red : .primary)
                    } header: {
                        Text("Final Check Amount (After-Tip)")
                    }
                }
                
                Text("Amount per Person")
                    .font(.subheadline)
                Text(totalPerPerson, format: localCurrency)
                    .font(.largeTitle)
                    .bold()
            }
            .navigationTitle("Split the Check")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    } 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
