//
//  ContentView.swift
//  CoffeeSleepCalc
//
//  Created by Basith on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffees = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("When do you want to wake up?").font(.headline)
                DatePicker("Wake Up", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .padding(.bottom)
                
                Text("Desired amount of sleep").font(.headline)
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    .padding(.bottom)
                
                Text("Daily coffee intake").font(.headline)
                Stepper("\(coffees) cup(s)", value: $coffees, in: 0...20)
                    .padding(.bottom)
                
                Button("Calculate", action: calculateSleep)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
            }
            .padding()
            .navigationTitle("CS Calc")
        }
    }
    
    func calculateSleep() {
        
    }
}

#Preview {
    ContentView()
}
