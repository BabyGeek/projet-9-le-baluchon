//
//  CRUDError.swift
//  LeBaluchon
//
//  Created by Paul Oggero on 26/07/2022.
//

import Foundation

/// CRUD error enum
public enum CRUDError: Error {
    case alreadyExists
}

extension CRUDError: LocalizedError {

    /// Errors descriptions
    public var errorDescription: String? {
        switch self {
        case .alreadyExists:
            return "Error while adding datas."
        }
    }

    /// Error failure reasons
    public var failureReason: String? {
        switch self {
        case .alreadyExists:
            return "Datas weren't able to store, it already exists in the saved datas."
        }
    }

    /// Error recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        default:
            return "Try restarting your application, if the error persist contact developer."
        }
    }
}
