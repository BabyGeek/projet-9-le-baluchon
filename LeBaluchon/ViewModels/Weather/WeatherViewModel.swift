//
//  WeatherManager.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 12/07/2022.
//

import Foundation


class WeatherViewModel: ObservableObject {
    @Published var weathers: [Weather] = [Weather]()
    private let url: String = "https://api.openweathermap.org/data/2.5/weather?lang=fr&units=metric"
    private let apiKey: String = "1e3be892b4867f22812876984dd1d18f"

    public func perform(lat latitude: Double, lon longitude: Double) {
        var url = self.url
        
        url.append("&lat=\(latitude)")
        url.append("&lon=\(longitude)")
        url.append("&appid=\(self.apiKey)")
                
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                
                DispatchQueue.main.async {
                    self.weathers.append(weather)
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

