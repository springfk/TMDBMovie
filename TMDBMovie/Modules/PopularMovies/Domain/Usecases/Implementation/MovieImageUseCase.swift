//
//  MovieImageUseCase.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403 AP.
//
import Foundation

class MovieImageUseCase: ImageUseCase {
    let baseURL: URL
    let network: ApiClient
    
    init(baseURL: URL, network: ApiClient) {
        self.baseURL = baseURL
        self.network = network
    }
    
    func getImageData(for url: String, type: TmdbImageType, completion: @escaping (Data?, (any Error)?) -> Void) {
        
        func build() -> URL? {
            let width: CGFloat = type == .poster ? 300 : 500
            var imagePath = url
            let imageSize = type.size(forWidth: width)
            if !imagePath.starts(with: "/") {
                imagePath = "/" + imagePath
            }
            
            let fullPath = baseURL.absoluteString + imageSize + imagePath
            guard let url = URL(string: fullPath) else {
                return nil
            }
            return url
        }
        guard let imageurl = build() else {
            completion(nil, nil)
            return
        }
        
        do {
            try network.requestData(endpoint: TMDBAnyRequest(path: imageurl.absoluteString, isFullPath: true)) { (result) in
                switch result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        } catch let error {
            completion(nil, error)
        }
        
    }
    
}
