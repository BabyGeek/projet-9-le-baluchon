//
//  CityViewModel.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 25/07/2022.
//

import Foundation

/// CityViewModel is an ObservableObject used to fetch datas from openweather geo API
class CityViewModel: NetworkManager, ObservableObject {
    @Published var error: AppError?
    @Published var results: [City]?
    private let url: String = ApiConstants.geoAPIURL
    private let apiKey: String = ApiConstants.weatherAPIKEY
    var lang = Locale.current.identifier

    #if DEBUG
    /// initialize the class
    override init() {
        super.init()
        self.reset()
    }

    /// Perform the base request to set target or add a favorite weather
    /// - Parameters:
    ///   - latitude: Value for the latitude of weather requested zone
    ///   - longitude: Value for the longitude of weather requested zone
    ///   - setTarget: Define if the requested weather is the target or not, false by default
    public func perform(search: String) {
        let params = [
            URLQueryItem(name: "q", value: search)
        ]

        guard let url = self.getQueryURL(params: params) else {
            self.error = AppError(error: NetworkError.wrongURLError)
            return
        }

        self.loadData(urlRequest: url, onSuccess: { (results: [City]) in
            self.results = results
        }, onFailure: { error in
            self.error = AppError(error: error)
        })
    }

    /// Build the API query related to additional parameters given
    /// - Parameter params: Optional params array of URLQueryItem
    /// - Returns: Optional URL
    private func getQueryURL(params: [URLQueryItem]? = nil) -> URL? {
        var urlComponent = URLComponents(string: self.url)

        let baseParams = [
            URLQueryItem(name: "lan", value: lang),
            URLQueryItem(name: "appid", value: apiKey)
        ]

        if let params = params {
            urlComponent?.queryItems = params + baseParams
        } else {
            urlComponent?.queryItems = baseParams
        }

        if let urlComponent = urlComponent {
            return urlComponent.url
        }

        return nil
    }
    #endif

    private func reset() {
        self.results = nil
    }
}
