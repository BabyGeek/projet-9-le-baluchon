//
//  CurrencyViewModel.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    @Published var target: Currency?
    @Published var base: Currency?
    
    private let url: String = ApiConstants.currencyAPIURL
    private let apiKey: String = ApiConstants.currencyAPIKEY
    
    @Published var result: ExchangeRateResult?
    
    
    public func perform(from: String, to: String) {
        self.performFor(from: from, to: to, amount: 1)
    }
    
    public func performFor(from: String, to: String, amount: Double) {
        var url = self.url
        
        url.append("?apikey=\(apiKey)")
        url.append("&to=\(to)")
        url.append("&from=\(from)")
        url.append("&amount=\(amount)")
        
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            // Convert to JSON
            do {
                let result = try JSONDecoder().decode(ExchangeRateResult.self, from: data)
                
                DispatchQueue.main.async {
                    self.result = result
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

