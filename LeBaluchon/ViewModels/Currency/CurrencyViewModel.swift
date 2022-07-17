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
    
    var result: ExchangeRateResult?
    
    
    public func perform(from: String, to: String) {
        self.performFor(from: from, to: to, amount: 1)
    }
    
    public func performFor(from: String, to: String, amount: Double) {
        print("done")
        getResult()
    }
    
    private func getResult() {
        self.result = ExchangeRateResult(value: 0)
    }
    
    public func getResultValue() -> Double {
        if let result = result {
            return result.value
        }
        
        return 0
    }
}

