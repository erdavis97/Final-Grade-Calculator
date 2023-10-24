//
//  ContentView.swift
//  Final Grade Calculator
//
//  Created by Ethan Davis on 10/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var currentGradeTextField = ""
    @State private var finalWeightTextField = ""
    @State private var desiredGrade = 0.0
    @State private var requiredGrade = 0.0
    @State private var letterGrade = ""
    var body: some View {
        VStack {
            CustomText(text: "Final Grade Calculator")
            CustomTextField(placeholder: "Current Semester Grade", variable: $currentGradeTextField)
            CustomTextField(placeholder: "Final Weight %", variable: $finalWeightTextField)
            Picker("Desired Semester Grade", selection: $desiredGrade) {
            Text ("A").tag (90.0)
            Text ("B").tag (80.0)
            Text ("C").tag (70.0)
            Text ("D").tag (60.0)
            }
            .pickerStyle (.segmented)
            .padding ()
            Text("Required Grade on the Final")
                .padding()
            CustomText(text: String(format: "%.2f", requiredGrade))
                .padding()
            CustomText(text: String(letterGrade))
                .padding(50)
                Spacer()
            }
        .onChange(of: desiredGrade, perform: { newValue in
            calculateGrade()
        })
        .background(requiredGrade > 100 ? Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0.0))
    }
    func calculateGrade() {
        if let currentGrade = Double(currentGradeTextField) {
            if let finalWeight = Double(finalWeightTextField) {
                if finalWeight < 100 && finalWeight > 0 {
                    let finalPercentage = finalWeight / 100.0
                    requiredGrade = max(0.0,(desiredGrade - (currentGrade * (1.0 - finalPercentage))) / finalPercentage)
                    if requiredGrade > 100 {
                        letterGrade = ("You need a time machine")
                    }
                    else if requiredGrade >= 89.5 {
                        letterGrade = ("You need an A")
                    }
                    else if requiredGrade >= 79.5 {
                        letterGrade = ("You need a B")
                    }
                    else if requiredGrade >= 70.0 {
                        letterGrade = ("You need a C")
                    }
                    else if requiredGrade >= 60.0 {
                        letterGrade = ("You need a D")
                    }
                    else if requiredGrade > 0.0 {
                        letterGrade = ("You need a F")
                    }
                    else if requiredGrade == 0.0 {
                        letterGrade = ("You need to show up to the final")
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
struct CustomTextField: View {
    let placeholder : String
    let variable : Binding<String>
    var body: some View {
        TextField(placeholder, text: variable)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .frame(width: 200, height: 30, alignment: .center)
            .font(.body)
            .padding()
    }
}
struct CustomText: View {
    let text : String
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
    }
}

