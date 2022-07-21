//
//  ContentView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

#if DEBUG
import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            List() {
                if let target = viewModel.target {
                    Section("Destination") {
                        WeatherRowView(weather: target)
                    }
                }
                
                Section("Favorites") {
                    ForEach(viewModel.favorites, id: \.self) { weather in
                        WeatherRowView(weather: weather)
                    }
                }
            }
            .navigationTitle("Weather")
        }
        .onAppear {
            viewModel.cleanResults()
            viewModel.perform(lat: 40.713051, lon: -74.007233, setTarget: true)
            viewModel.perform(lat: 43.125191, lon: 5.931040)
            viewModel.perform(lat: 10.382129, lon: 105.434076)
        }
        .alert(item: $viewModel.error) { error in
            guard let descrition = error.error.errorDescription, let message = error.error.failureReason else {
                return Alert(
                    title: Text(NetworkError.unknown.errorDescription!),
                    message: Text(NetworkError.unknown.failureReason!))
            }
            
            return Alert(
                title: Text(descrition),
                message: Text(message))
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
#endif
