//
//  TranslationViewModel.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 21/07/2022.
//

import Foundation

class TranslationViewModel: NetworkManager, ObservableObject {
    @Published var error: AppError? = nil
    @Published var results: TranslationDictionnary? = nil
    @Published var autoloadSource: Bool = true
    @Published var langs: [TranslationLanguage] = [TranslationLanguage]()
    @Published var source: String = "fr"
    @Published var target: String = "en"
    
    
    private let url: String = ApiConstants.translationAPIURL
    private let apiKey: String = ApiConstants.translationAPIKEY
    
    override init() {
        super.init()
        self.getLangs()
    }
    
#if DEBUG
    /// Perform translate request
    /// - Parameter text: Text to translate
    public func performForText(_ text: String) {
        var params = [
            URLQueryItem(name: "target", value: self.target),
            URLQueryItem(name: "q", value: text)
        ]
        
        if(!self.autoloadSource) {
            params.append(URLQueryItem(name: "source", value: self.source))
        }
        
        if let url = self.getURL(resource: nil, params: params) {
            self.loadData(urlRequest: url) { (translationData: TranslationData) in
                self.results = translationData.data
            } onFailure: { error in
                self.error = AppError(error: error)
            }

        }
    }
#endif
    
    /// Load langs from API
    private func getLangs() {
        if let url = self.getURL(resource: "languages", params: [URLQueryItem(name: "target", value: self.source)]) {
            self.loadData(urlRequest: url) { (languageDictionnary: TranslationLanguageData) in
                self.langs = languageDictionnary.data.languages.sorted(by: { $0.name < $1.name })
            } onFailure: { error in
                self.error = AppError(error: error)
            }
            
        }
    }
    
    /// Build the API query related to additional parameters given
    /// - Parameters:
    ///   - resource: Type of resource to reach in the api
    ///   - params: Optional array of params
    /// - Returns: Optional URL
    private func getURL(resource: String? = nil, params: [URLQueryItem] = [URLQueryItem]()) -> URL? {
        var url = self.url
        
        if let resource = resource {
            url.append("/\(resource)")
        }
        
        var urlComponent = URLComponents(string: url)
        
        
        let baseParams = [
            URLQueryItem(name: "key", value: self.apiKey),
        ]
        
        urlComponent?.queryItems = params + baseParams

        return urlComponent?.url
    }
}
