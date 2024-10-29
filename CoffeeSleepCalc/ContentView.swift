//
//  ContentView.swift
//  CoffeeSleepCalc
//
//  Created by Basith on 29/10/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffees = 1
    
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var showAlert = false
    
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
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") {}
            } message: {
                Text(alertMsg)
            }
        }
    }
    
    func calculateSleep() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let timeComponent = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hours = (timeComponent.hour ?? 0) * 60 * 60
            let minutes = (timeComponent.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffees))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is"
            alertMsg = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMsg = "Something went wrong while calculating sleep time."
        }
        
        showAlert = true
    }
}

#Preview {
    ContentView()
}
