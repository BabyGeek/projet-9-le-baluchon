//
//  NetworkManager.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 19/07/2022.
//

import Foundation


class NetworkManager {
    func loadData<T:Decodable>(urlRequest url: URL, onSuccess success: @escaping (T) -> (), onFailure failure: @escaping (Error) -> ()) {
        let task = URLSession.shared.dataTask(with: url)
        {
            data, response, error in
            
            guard let data = data, error == nil else {
                failure(error!)
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    success(object)
                }
            } catch {
                failure(error)
            }
            
        }
        
        task.resume()
    }
}
