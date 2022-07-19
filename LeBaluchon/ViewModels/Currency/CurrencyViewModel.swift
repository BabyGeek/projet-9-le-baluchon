//
//  CurrencyViewModel.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import Foundation

class CurrencyViewModel: NetworkManager, ObservableObject {
    private let url: String = ApiConstants.currencyAPIURL
    private let apiKey: String = ApiConstants.currencyAPIKEY
    
    @Published var result: ExchangeRateResult?
    
    @Published var symbols: [CurrencySymbol] = [CurrencySymbol]()
    private var symbolsLoaded = false
    
    
    public func perform(from: String, to: String) {
        self.performFor(from: from, to: to, amount: 1)
    }
    
    public func performFor(from: String, to: String, amount: Double) {

        let params: [Any] = [
            from,
            to,
            amount
        ]
        
        guard let url = self.getURL(resource: "pair", params: params) else {
            return
        }
        
        DispatchQueue.main.async {
            self.loadData(
                urlRequest: url, onSuccess: { result in
                    self.result = result
                }, onFailure: { error in
                    print(error)
                })
        }
        
    }
    
    public func performSymbols() {
        if self.symbolsLoaded {
            // Already loaded
            return
        }
        
        guard let url = self.getURL(resource: "codes") else {
            return
        }
        
        DispatchQueue.main.async {
            self.loadData(
                urlRequest: url, onSuccess: { (dictionnary: CurrencyDictionnary) in
                    self.symbols = dictionnary.currencies
                    self.symbolsLoaded = true
                    
                }, onFailure: { error in
                    print(error.localizedDescription)
                })
            
        }
    }
    
    
    private func getURL(resource: String, params: [Any]? = nil) -> URL? {
        var url = self.url.replacingOccurrences(of: "{apiKey}", with: self.apiKey)
        url = url.replacingOccurrences(of: "{resource}", with: resource)
        
        if let params = params {
            for param in params {
                url.append("/\(param)")
            }
        }
        
        return URL(string: url)
    }
}

