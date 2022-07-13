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
            List(viewModel.weathers, id: \.self) { weather in
                HStack {
                    Text(weather.name)
                    Text("\(weather.main.temp)")
                }
                .padding(3)
            }
        }
        .navigationTitle("Météo")
        .onAppear {
            viewModel.perform(lat: 35, lon: 13)
        }
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
