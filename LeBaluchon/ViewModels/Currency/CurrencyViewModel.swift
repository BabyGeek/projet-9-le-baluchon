//
//  CurrencyViewModel.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 17/07/2022.
//

import Foundation

/// CurrencyViewModel is an ObservableObject used to fetch datas from exchangerate API
class CurrencyViewModel: NetworkManager, ObservableObject {
    @Published var error: AppError? = nil
    private let url: String = ApiConstants.currencyAPIURL
    private let apiKey: String = ApiConstants.currencyAPIKEY
    
    @Published var source: String = "EUR"
    @Published var target: String = "VND"
    @Published var amount: String = "1"
    
    @Published var result: ExchangeRateResult?
    @Published var symbols: [CurrencySymbol] = [CurrencySymbol]()
    
    private var symbolsLoaded = false
    
    override init() {
        super.init()
        self.performSymbols()
    }
    
#if DEBUG
    /// Perform the base request to set the exchange result
    /// - Parameters:
    ///   - from: Value for the currency you want to exchange
    ///   - to: Value for the desired exchange currency
    ///   - amount: Amount to exchange, 1 by default
    public func perform() {
        
        let params: [String] = [
            self.source,
            self.target,
            self.amount
        ]
        
        guard let url = self.getURL(resource: "pair", params: params) else {
            self.error = AppError(error: .wrongURLError)
            return
        }
        
        self.loadData(
            urlRequest: url, onSuccess: { result in
                self.result = result
            }, onFailure: { error in
                self.error = AppError(error: error)
            })
    }
#endif
    
    public func switchCurrencies() {
        let tempSource = self.source
        self.source = self.target
        self.target = tempSource
    }
    
    public func getLocaleStringFor(_ type: CurrencyType = .source) -> String {
        var locale = self.source
        var value: Double? = nil
        var localeString = ""
        
        if type == .target {
            locale = self.target
            value = self.result?.result
        } else if type == .source {
            value = Double(self.amount)
        }
        
        if let value = value {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            if let locale = self.getCurrencySymbol(locale)
            {
                formatter.currencySymbol = locale
            }
            
            formatter.locale = Locale.current
            if let formattedAmount = formatter.string(from: value as NSNumber) {
                localeString = formattedAmount
            }
        }
        
        return localeString
    }
    
    private func getCurrencySymbol(_ locale: String) -> String? {
        return self.symbols.first(where: { $0.code == locale })?.getSymbol()
    }
    
    /// Fetch currencies symbols from the API if it isn't already loaded
    private func performSymbols() {
        if self.symbolsLoaded {
            return
        }
        if let url = self.getURL(resource: "codes") {
            self.loadData(
                urlRequest: url, onSuccess: { (dictionnary: CurrencyDictionnary) in
                    self.symbols = dictionnary.currencies
                    self.symbolsLoaded = true
                    
                }, onFailure: { error in
                    print(error.localizedDescription)
                })
        }
    }
    
    /// Build the API query related to additional parameters given
    /// - Parameters:
    ///   - resource: Type of resource to reach in the api
    ///   - params: Optional array of params
    /// - Returns: Optional URL
    private func getURL(resource: String, params: [String] = [String]()) -> URL? {
        var url = self.url.replacingOccurrences(of: "{apiKey}", with: self.apiKey)
        url = url.replacingOccurrences(of: "{resource}", with: resource)
        
        for param in params {
            url.append("/\(param)")
        }
        
        return URL(string: url)
    }
}

