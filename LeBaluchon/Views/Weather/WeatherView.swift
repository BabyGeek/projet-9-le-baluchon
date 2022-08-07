//
//  ContentView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import SwiftUI

/// Weather view page
struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        if viewModel.isLoading {
            NavigationView {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        } else {
            NavigationView {
                Form {
                    if let target = viewModel.target {
                        Section(header: Text("Destination")) {
                            WeatherRowView(weather: target)
                        }
                    }

                    Section(header: Text("Favorites")) {
                        ForEach(viewModel.favorites, id: \.self) { weather in
                            WeatherRowView(weather: weather)
                        }
                    }
                }
                .navigationTitle("Weather")
                .onAppear {
                    viewModel.cleanResults()
                    viewModel.perform(lat: 40.713051, lon: -74.007233, setTarget: true)
                    viewModel.perform(lat: 43.125191, lon: 5.931040)
                    viewModel.perform(lat: 10.382129, lon: 105.434076)
                }
                .alert(item: $viewModel.error) { error in
                    return Alert(
                        title: Text(error.error.errorDescription ?? NetworkError.unknown.errorDescription!),
                        message: Text(error.error.failureReason ?? NetworkError.unknown.failureReason!)
                    )
                }
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
