//
//  NetworkManager.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 19/07/2022.
//

import Foundation


/// Manage networking requests
class NetworkManager {
    /// Load data and decode them if no errors
    /// - Parameters:
    ///   - url: url to follow for the request
    ///   - success: callback on success
    ///   - failure: callback on failure
    func loadData<T:Decodable>(urlRequest url: URL, onSuccess success: @escaping (T) -> (), onFailure failure: @escaping (NetworkError) -> ()) {
        let task = URLSession.shared.dataTask(with: url)
        {
            data, response, error in
            
            guard let data = data, error == nil else {
                failure(.loadDataError)
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    success(object)
                }
            } catch {
                failure(.failure)
            }
            
        }
        
        task.resume()
    }
}
