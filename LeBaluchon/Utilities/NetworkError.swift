//
//  NetworkError.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 20/07/2022.
//

import Foundation

public enum NetworkError: Error {
    case failure
    case wrongURLError
    
    case loadDataError
    
    case unknown
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .wrongURLError:
            return "Network error"
        case .loadDataError, .failure:
            return "Data fetching error"
        case .unknown:
            return "Unexpected error"
        }
    }
     
    public var failureReason: String? {
        switch self {
        case .failure:
            return "Error while decoding datas."
        case .wrongURLError:
            return "Error while creating the url."
        case .loadDataError:
            return "Error while fetching data from API."
        case .unknown:
            return "An unexpected error as been detected."
        }
    }
     
    public var recoverySuggestion: String? {
        switch self {
        default:
            return "Try restarting your application, if the error persist contact developer."
        }
    }
}

struct AppError: Identifiable {
    let id: UUID
    let error: NetworkError
    
    init(error: NetworkError) {
        self.id = UUID()
        self.error = error
    }
}
