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
    
    var result: CurrencyResult?
    
    
    public func perform(lat latitude: Double, lon longitude: Double, setTarget: Bool = false) {
    }
}

