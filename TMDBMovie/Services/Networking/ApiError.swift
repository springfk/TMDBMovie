//
//  ApiError.swift
//  TMDBMovies
//
//  Created by Bahar on 9/25/1403 AP.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case validationResponse(statusCode: Int, message: String?)
    case decodingError(Error)
    case encodingError(Error)
    case notConnectedToInternet
    
    var errorDescription: String? {
        return localizedDescription
    }
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .requestFailed(let error ):
            "Request Failed: \(error.localizedDescription)"
        case .validationResponse(statusCode: let statusCode, message: let message):
            "Invalid Response: \(statusCode) with message \(message ?? ""))"
        case .decodingError(let error):
            "Decoding Error : \(error.localizedDescription) "
        case .encodingError(let error):
            "Encoding Error : \(error.localizedDescription) "
        case .notConnectedToInternet:
            "There is no Internet Connection"
        }
    }
}
