//
//  NetworkManager.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 19/07/2022.
//

import Foundation

/// Manage networking requests
class NetworkManager {
    @Published var isLoading: Bool = false
    /// Load data and decode them if no errors
    /// - Parameters:
    ///   - url: url to follow for the request
    ///   - success: callback on success
    ///   - failure: callback on failure
    func loadData<T: Decodable>(urlRequest url: URL,
                                onSuccess success: @escaping (T) -> Void,
                                onFailure failure: @escaping (NetworkError) -> Void) {
        self.isLoading = true
        let task = URLSession.shared.dataTask(with: url) { data, _, error in

            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    failure(.loadDataError)
                    return
                }

                do {
                    let object = try JSONDecoder().decode(T.self, from: data)

                    success(object)

                } catch {
                    failure(.failure)
                }
            }
        }
        self.isLoading = false
        task.resume()
    }
}
