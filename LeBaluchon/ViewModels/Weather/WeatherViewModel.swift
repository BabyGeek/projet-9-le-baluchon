//
//  WeatherViewModel.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import Foundation
import SwiftUI


/// WeatherViewModel is an ObservableObject used to fetch datas from weather API
class WeatherViewModel: NetworkManager, ObservableObject {
    @Published var error: AppError? = nil
    
    @Published var target: Weather?
    @Published var favorites: [Weather] = [Weather]()
    private let url: String = ApiConstants.weatherAPIURL
    private let apiKey: String = ApiConstants.weatherAPIKEY
    var lang = "en"
    var units = "metric"
    
    #if DEBUG
    /// Perform the base request to set target or add a favorite weather
    /// - Parameters:
    ///   - latitude: Value for the latitude of weather requested zone
    ///   - longitude: Value for the longitude of weather requested zone
    ///   - setTarget: Define if the requested weather is the target or not, false by default
    public func perform(lat latitude: Double, lon longitude: Double, setTarget: Bool = false) {
        let params = [
            URLQueryItem(name: "lat", value: String(format: "%f", latitude)),
            URLQueryItem(name: "lon", value: String(format: "%f", longitude))
        ]
        
        guard let url = self.getQueryURL(params: params) else {
            self.error = AppError(error: .wrongURLError)
            return
        }
        
        self.loadData(urlRequest: url, onSuccess: { (weather: Weather) in
            if(setTarget) {
                self.target = weather
            }else{
                self.favorites.append(weather)
            }
        }, onFailure: { error in
            self.error = AppError(error: error)
        })
    }
    
    /// Clean favorites weathers
    public func cleanResults() {
        favorites = [Weather]()
    }
    
    /// Build the API query related to additional parameters given
    /// - Parameter params: Optional params array of URLQueryItem
    /// - Returns: Optional URL
    private func getQueryURL(params: [URLQueryItem]? = nil) -> URL? {
        var urlComponent = URLComponents(string: self.url)
        
        let baseParams = [
            URLQueryItem(name: "lan", value: lang),
            URLQueryItem(name: "units", value: units),
            URLQueryItem(name: "appid", value: apiKey),
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
}

