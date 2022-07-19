//
//  WeatherManager.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import Foundation


class WeatherViewModel: NetworkManager, ObservableObject {
    @Published var target: Weather?
    @Published var favorites: [Weather] = [Weather]()
    private let url: String = ApiConstants.weatherAPIURL
    private let apiKey: String = ApiConstants.weatherAPIKEY
    var lang = "en"
    var units = "metric"
    
    public func perform(lat latitude: Double, lon longitude: Double, setTarget: Bool = false) {
        let params = [
            URLQueryItem(name: "lat", value: latitude.formatted()),
            URLQueryItem(name: "lon", value: longitude.formatted())
        ]
        
        guard let url = self.getQueryURL(params: params) else {
            return
        }
        
        DispatchQueue.main.async {
            self.loadData(urlRequest: url, onSuccess: { (weather: Weather) in
                if(setTarget) {
                    self.target = weather
                }else{
                    self.favorites.append(weather)
                }
            }, onFailure: { error in
                print(error.localizedDescription)
            })
        }
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
}

