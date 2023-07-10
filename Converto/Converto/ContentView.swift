//
//  ContentView.swift
//  Converto
//
//  Created by Philipp Pielmeier on 06.07.23.
//

import SwiftUI

struct ContentView: View {
    @State private var InputTemp = 0.0
    @State private var selectedInputTempScale: TempScales = .celsius
    @State private var selectedOutputTempScale: TempScales = .celsius
    
    enum TempScales: String, CaseIterable, Identifiable {
        case celsius, kelvin, fahrenheit
        var id: Self { self }
    }

    var CelBaseTemp: Double {
        var CelsiusBaseTemp = 0.0
        if (selectedInputTempScale == .celsius){
            CelsiusBaseTemp = InputTemp
        } else if(selectedInputTempScale == .fahrenheit){
            CelsiusBaseTemp = InputTemp - 32 * 5 / 9
        } else{
            CelsiusBaseTemp = InputTemp - 273.15
        }
        return CelsiusBaseTemp
    }
    
    var ConvertedTemp: Double {
        var convTemp = 0.0
        if(selectedOutputTempScale == .celsius){
            convTemp = CelBaseTemp
        } else if(selectedOutputTempScale == .fahrenheit){
            convTemp = CelBaseTemp * 1.8 + 32
        } else{
            convTemp = CelBaseTemp + 273.15
        }
        convTemp = convTemp.rounded()
        return convTemp
    }
   

    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Temperature", value: $InputTemp, format: .number).keyboardType(.decimalPad)

                    Picker("Input Temperature Scale", selection: $selectedInputTempScale) {
                        Text("Celsius").tag(TempScales.celsius)
                        Text("Kelvin").tag(TempScales.kelvin)
                        Text("Fahrenheit").tag(TempScales.fahrenheit)
                    }
                } header: {
                    Text("Input Temperature")
                }
                
                Section{
                    Picker("Output Temperature Scale", selection: $selectedOutputTempScale) {
                            Text("Celsius").tag(TempScales.celsius)
                            Text("Kelvin").tag(TempScales.kelvin)
                            Text("Fahrenheit").tag(TempScales.fahrenheit)
                        }
                    Text(ConvertedTemp, format: .number)
                        } header: {
                            Text("Converted Temperature")
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
