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
            viewModel.perform(lat: 35, lon: 13)
            viewModel.perform(lat: 13, lon: 35)
            viewModel.perform(lat: 35, lon: 139)
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
