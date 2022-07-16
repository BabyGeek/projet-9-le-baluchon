//
//  ContentView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.weathers) { weather in
                WeatherRowView(weather: weather)
            }
            .navigationTitle("Weather")
        }
        .onAppear {
            viewModel.cleanResults()
            viewModel.perform(lat: 40.713051, lon: -74.007233)
            viewModel.perform(lat: 43.125191, lon: 5.931040)
            viewModel.perform(lat: 10.382129, lon: 105.434076)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
