//
//  ApiRequestable.swift
//  TMDBMovies
//
//  Created by Bahar on 9/25/1403 AP.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol ApiRequestable  {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HTTPMethod { get }
    var headerParameters: [String: String] { get }
    var queryParametersEncodable: Encodable? { get }
    var queryParameters: [String: Any] { get }
    var bodyParametersEncodable: Encodable? { get }
    var bodyParameters: [String: Any] { get }
    var paramsEncoder: APIParamEncoder? { get }
    var requiresAuthentication: Bool { get }
    
    func urlRequest(baseURL: URL?, apiKey: String?, bearerToken: String?) throws -> URLRequest
}



extension ApiRequestable {
    
        func url(baseURL: URL?, apiKey: String?, bearerToken: String?) throws -> URL {
            var endpoint = path
            
            if let baseURL = baseURL, !isFullPath {
                let base = baseURL.absoluteString.last != "/"
                ? baseURL.absoluteString + "/"
                : baseURL.absoluteString
                endpoint = base.appending(path)
            }
           
            guard var urlComponents = URLComponents(string: endpoint) else {
                throw APIError.invalidURL
            }
            
            var urlQueryItems = [URLQueryItem]()
            
            // Add TMDB API Key if required and available
            if requiresAuthentication, let apiKey = apiKey {
                urlQueryItems.append(URLQueryItem(name: "api_key", value: apiKey))
            }
            
            // Add additional query parameters
            let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
            queryParameters.forEach {
                urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
            }
            
            urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
            guard let url = urlComponents.url else { throw APIError.invalidURL }
            return url
        }
        
        func urlRequest(baseURL: URL?, apiKey: String?, bearerToken: String?) throws -> URLRequest {
            let url = try self.url(baseURL: baseURL, apiKey: apiKey, bearerToken: bearerToken)
            var urlRequest = URLRequest(url: url)
            var allHeaders: [String: String] = [:]
            
            // Add TMDB Bearer Token if required and available
            if requiresAuthentication, let bearerToken = bearerToken {
                allHeaders["Authorization"] = "Bearer \(bearerToken)"
            }
            
            // Add additional headers
            headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }
            
            urlRequest.httpMethod = method.rawValue
            urlRequest.allHTTPHeaderFields = allHeaders
            
            guard let paramsEncoder = paramsEncoder else {
                return urlRequest
            }
            
            if let bodyParams = bodyParametersEncodable {
                urlRequest = try paramsEncoder.encodeRequestParameters(urlRequest, bodyParams)
            } else if !bodyParameters.isEmpty {
                urlRequest = try paramsEncoder.encodeRequestParameters(urlRequest, bodyParameters)
            }
            
            return urlRequest
        }
    }



private extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
