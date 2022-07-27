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
    @Published var error: AppError?
    @Published var target: Weather?
    @Published var favorites: [Weather] = [Weather]()

    private let url: String = ApiConstants.weatherAPIURL
    private let apiKey: String = ApiConstants.weatherAPIKEY
    var lang = Locale.current.identifier
    var units = "metric"

    #if DEBUG
    override init() {
        super.init()
        self.isLoading = true
        self.load()
        self.isLoading = false
    }

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
            self.error = AppError(error: NetworkError.wrongURLError)
            return
        }
        self.fetchData(url: url) { (weather: Weather) in
            if setTarget {
                self.target = weather
            } else {
                self.favorites.append(weather)
            }
        }
    }

    private func fetchData<T: Decodable>(
        url: URL,
        success: @escaping (T) -> Void) {

        self.loadData(urlRequest: url, onSuccess: { object in
            success(object)
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
            URLQueryItem(name: "units", value: units),
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
    
    public func load() {
        self.loadFavorites()
        self.loadTarget()
    }

    /// Load favorites saved
    public func loadFavorites() {
        self.favorites = [Weather]()
        let type = CityType.favorite
        let defaults = UserDefaults.standard
        let favoriteCities  = defaults.array(
            forKey: "\(type.rawValue)Baluchon") as? [Int] ?? [Int]()
        

        for cityID in favoriteCities {
            let params = [
                URLQueryItem(name: "id", value: String(format: "%d", cityID))
            ]
            
            guard let url = self.getQueryURL(params: params) else {
                self.error = AppError(error: NetworkError.wrongURLError)
                return
            }
            self.fetchData(url: url) { (weather: Weather) in
                self.favorites.append(weather)
            }
        }
    }
    
    /// Load destination saved
    public func loadTarget() {
        let type = CityType.destination
        let defaults = UserDefaults.standard
        let cityID  = defaults.integer(
            forKey: "\(type.rawValue)Baluchon")
        
        if cityID == 0 {
            return
        }
        
        let params = [ URLQueryItem(name: "id", value: String(format: "%d", cityID)) ]
        guard let url = self.getQueryURL(params: params) else {
            self.error = AppError(error: NetworkError.wrongURLError)
            return
        }
        self.fetchData(url: url) { (weather: Weather) in
            self.target = weather
        }
    }
    
    public func saveCity(_ city: City, type: CityType) {
        let defaults = UserDefaults.standard
        
        let params = [
            URLQueryItem(name: "lat", value: String(format: "%f", city.lat)),
            URLQueryItem(name: "lon", value: String(format: "%f", city.lon))
        ]

        guard let url = self.getQueryURL(params: params) else {
            self.error = AppError(error: NetworkError.wrongURLError)
            return
        }

        self.fetchData(url: url) { (weather: Weather) in
            let newID = weather.id
            
            if type == .favorite {
                var savedCities = defaults.object(
                    forKey: "\(type.rawValue)Baluchon") as? [Int] ?? [Int]()

                if let _ = savedCities.first(where: { id in
                    return id == newID
                }) {
                    self.error = AppError(error: CRUDError.alreadyExists)
                    return
                }
                
                savedCities.append(newID)
                defaults.set(savedCities, forKey: "\(type.rawValue)Baluchon")
            } else {
                defaults.set(newID, forKey: "\(type.rawValue)Baluchon")
            }
        }

        
    }

    public func synchData() {
        let defaults = UserDefaults.standard
        if self.favorites.isEmpty {
            defaults.set([Int](), forKey: "\(CityType.favorite.rawValue)Baluchon")
        } else {
            var weatherFavorites = [Int]()
            for weather in self.favorites {
                weatherFavorites.append(weather.id)
            }
            
            defaults.set(weatherFavorites, forKey: "\(CityType.favorite.rawValue)Baluchon")
        }
        
        defaults.set(target?.id, forKey: "\(CityType.destination.rawValue)Baluchon")
    }
    #endif
}
