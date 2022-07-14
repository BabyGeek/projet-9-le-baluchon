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
        List(viewModel.weathers, id: \.self) { weather in
            WeatherRowView(weather: weather)
        }
        .onAppear {
            viewModel.perform(lat: 43.125191, lon: 5.931040)
        }
    }
}

struct WeatherRowView: View {
    let weather: Weather
    
    var body: some View {
        HStack {
            Text(weather.name)
            Text("\(weather.main.temp.formatted())")
        }
        .padding(3)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
