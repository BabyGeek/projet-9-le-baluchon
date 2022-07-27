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
    @State var addFavorite = false
    var body: some View {
        
        if #available(iOS 15.0, *) {
            NavigationView {
                main
            }
        } else {
            NavigationView {
                main
            }
            .toolbar {
                EditButton()
            }
        }
    }
}

/// Weather view main
extension WeatherView {

    var main: some View {
            List {
                if viewModel.isLoading {
                    Text("Loading..")
                } else {
                    if let target = viewModel.target {
                        Section(header: Text("Destination")) {
                            NavigationLink {
                                        CityFormView(type: .destination)
                                            .environmentObject(viewModel)
                                            .navigationTitle("Update destination")
                            } label: {
                                WeatherRowView(weather: target)
                            }

                        }
                    } else {
                        NavigationLink("No destination city yet. Add one.") {
                            CityFormView(type: .destination)
                                .environmentObject(viewModel)
                        }
                    }

                    Section(header: Text("Favorites")) {
                        if viewModel.favorites.isEmpty {
                                NavigationLink("No favorite city yet. Add your first one") {
                                    CityFormView(type: .favorite)
                                        .environmentObject(viewModel)
                                }
                        } else {
                            favorites
                        }
                    }
                }
            }
            .navigationTitle("Weather")
            .sheet(isPresented: $addFavorite, content: {
                CityFormView(type: .favorite)
                    .environmentObject(viewModel)
            })
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
            .onReceive(NotificationCenter.default.publisher(for: UIScene.didEnterBackgroundNotification)) { _ in
                viewModel.synchData()
            }
        
        }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
#endif
