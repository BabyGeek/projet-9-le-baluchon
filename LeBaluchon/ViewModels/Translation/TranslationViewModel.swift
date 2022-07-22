//
//  TranslationViewModel.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 21/07/2022.
//

import Foundation

class TranslationViewModel: NetworkManager, ObservableObject {
    @Published var error: AppError? = nil
    @Published var results: [Translation]? = nil
    @Published var autoloadSource: Bool = true
    @Published var langs: [TranslationLanguage] = [TranslationLanguage]()
    @Published var source: String = "en"
    @Published var target: String = "fr"
    
    
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
    public func performForText(_ text: String) {
        let params = [
            URLQueryItem(name: "target", value: self.target),
            URLQueryItem(name: "source", value: self.source),
            URLQueryItem(name: "q", value: text)
        ]
        
        if let url = self.getURL(resource: nil, params: params) {
            self.loadData(urlRequest: url) { (translationData: TranslationData) in
                self.results = translationData.data.translations
            } onFailure: { error in
                self.error = AppError(error: error)
            }

        }
    }
#endif
    
    private func getLangs() {
        if self.languagesLoaded {
            return
        }
        
        if let url = self.getURL(resource: "languages", params: [URLQueryItem(name: "target", value: self.source)]) {
            self.loadData(urlRequest: url) { (languageDictionnary: TranslationLanguageData) in
                self.langs = languageDictionnary.data.languages.sorted(by: { $0.language < $1.language })
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
    private func getURL(resource: String? = nil, params: [URLQueryItem]? = nil) -> URL? {
        var url = self.url
        
        if let resource = resource {
            url.append("/\(resource)")
        }
        
        var urlComponent = URLComponents(string: url)
        
        
        let baseParams = [
            URLQueryItem(name: "key", value: self.apiKey),
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
}
