//
//  CityFormView.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 26/07/2022.
//

import SwiftUI

struct CityFormView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @Environment(\.dismiss) var dismiss
    var type: CityType

    @State var search: String = ""
    @ObservedObject var viewModel = CityViewModel()

    var body: some View {
        Form {
            if #available(iOS 15.0, *) {
                TextField("Search a city", text: $search)
                    .modifier(TextFieldClearButton(text: $search))
                    .onSubmit {
                        viewModel.perform(search: search)
                    }
                    .submitLabel(.done)
            } else {
                TextField("Search a city", text: $search)
                    .modifier(TextFieldClearButton(text: $search))
                Button {
                    viewModel.perform(search: search)
                } label: {
                    Text("Search")
                }
            }
            if search.isEmpty {
                Text("Provide a city name to see possible results.")
            } else {
                if viewModel.isLoading {
                    Text("Loading...")
                }

                if viewModel.error != nil {
                    Text("No results found.")
                }

                if viewModel.results != nil {
                    if let results = viewModel.results {
                        if !results.isEmpty {
                            ForEach(results, id: \City.self) { result in
                                HStack {
                                    Text("\(result.description)")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .onTapGesture {
                                    weatherViewModel.saveCity(result, type: type)
                                    weatherViewModel.load()
                                    self.dismiss()
                                }
                            }
                        } else {
                            Text("No results found.")
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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

struct CityFormView_Previews: PreviewProvider {
    static var previews: some View {
        CityFormView(type: .destination)
            .environmentObject(WeatherViewModel())
    }
}
