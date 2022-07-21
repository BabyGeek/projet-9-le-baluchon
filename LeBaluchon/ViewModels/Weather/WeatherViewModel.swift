//
//  WeatherViewModel.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import Foundation
import SwiftUI


class WeatherViewModel: NetworkManager, ObservableObject {
    @Published var error: AppError? = nil
    
    @Published var target: Weather?
    @Published var favorites: [Weather] = [Weather]()
    private let url: String = ApiConstants.weatherAPIURL
    private let apiKey: String = ApiConstants.weatherAPIKEY
    var lang = "en"
    var units = "metric"
    
    #if DEBUG
    public func perform(lat latitude: Double, lon longitude: Double, setTarget: Bool = false) {
        let params = [
            URLQueryItem(name: "lat", value: latitude.formatted()),
            URLQueryItem(name: "lon", value: longitude.formatted())
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
    
    public func cleanResults() {
        favorites = [Weather]()
    }
    
    private func getQueryURL(params: [URLQueryItem]) -> URL? {
        var urlComponent = URLComponents(string: self.url)
        
        let baseParams = [
            URLQueryItem(name: "lan", value: lang),
            URLQueryItem(name: "units", value: units),
            URLQueryItem(name: "appid", value: apiKey),
        ]
        
        urlComponent?.queryItems = params + baseParams
        
        if let urlComponent = urlComponent {
            return urlComponent.url
        }
        
        return nil
    }
    #endif
}

