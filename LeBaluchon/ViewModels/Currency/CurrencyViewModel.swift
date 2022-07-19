//
//  CurrencyViewModel.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    private let url: String = ApiConstants.currencyAPIURL
    private let apiKey: String = ApiConstants.currencyAPIKEY
    
    @Published var result: ExchangeRateResult?
    @Published var symbols: [CurrencySymbol] = [CurrencySymbol]()
    private var symbolsLoaded = false
    
    
    public func perform(from: String, to: String) {
        self.performFor(from: from, to: to, amount: 1)
    }
    
    public func performFor(from: String, to: String, amount: Double) {
        var url = self.url.replacingOccurrences(of: "{apiKey}", with: self.apiKey, options: .literal, range: nil)
        url = url.replacingOccurrences(of: "{resource}", with: "pair", options: .literal, range: nil)
        
        url.append("/\(from)")
        url.append("/\(to)")
        url.append("/\(amount)")
        
        guard let url = URL(string: url) else {
            return
        }
        
        print(url)
        
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
    
    public func performSymbols() {
        print(self.symbolsLoaded)
        if self.symbolsLoaded {
            // Already loaded
            return
        }
        
        var url = self.url.replacingOccurrences(of: "{apiKey}", with: self.apiKey, options: .literal, range: nil)
        url = url.replacingOccurrences(of: "{resource}", with: "codes", options: .literal, range: nil)
        
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
                let result = try JSONDecoder().decode(CurrencyDictionnary.self, from: data)
                DispatchQueue.main.async {
                    self.symbols = result.currencies
                    self.symbolsLoaded = true
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}

