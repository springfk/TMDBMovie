//
//  TMDBPopularMoviesRequest.swift
//  TMDBMovies
//
//  Created by Bahar on 9/25/1403 AP.
//

import Foundation

struct TMDBPopularMoviesRequest: ApiRequestable {
    let path: String = "movie/popular"
    let isFullPath: Bool = false
    let method: HTTPMethod = .get
    let headerParameters: [String: String] = [:]
    let queryParametersEncodable: Encodable? = nil
    let queryParameters: [String: Any]
    let bodyParametersEncodable: Encodable? = nil
    let bodyParameters: [String: Any] = [:]
    let paramsEncoder: APIParamEncoder? = JSONAPIParamEncoder(encoder: JSONEncoder())
    let requiresAuthentication: Bool = true

    init(language: String = "en-US", page: Int = 1) {
        self.queryParameters = [
            "language": language,
            "page": page
        ]
    }
}
