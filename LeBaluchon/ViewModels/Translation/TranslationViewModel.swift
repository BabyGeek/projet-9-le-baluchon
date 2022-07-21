//
//  TranslationViewModel.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 21/07/2022.
//

import Foundation

class TranslationViewModel: NetworkManager, ObservableObject {
    @Published var error: AppError? = nil
    @Published var result = ""
    @Published var langs: [TranslationLanguage] = [TranslationLanguage]()
    
    private let url: String = ApiConstants.translationAPIURL
    private let apiKey: String = ApiConstants.translationAPIKEY
    private var languagesLoaded: Bool {
        return !self.langs.isEmpty
    }
    
    override init() {
        super.init()
        self.getLangs()
    }
    
    #if DEBUG
    public func perform() {
        
    }
    #endif
    
    private func getLangs() {
        
    }
    
    private func getURLWithParams(_ params: [Any]?) {
        
    }
}
