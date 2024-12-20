//
//  MoviesListUsecaseImp.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403 AP.
//

import Foundation
import UIKit

final class MoviesListUsecaseImp: MoviesListUsecase {
    
    let repository : MoviesRepositoryInterface
    
    init(repository: MoviesRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchMovies(page: Int, completion: @escaping (Result<MoviePagination, any Error>) -> Void) {
        repository.getMoviesList(page: page) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
    }
    
    func searchMovies(query: String, page: Int, completion: @escaping (Result<MoviePagination, any Error>) -> Void) {
       
        repository.searchMovies(query: query, page: page) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
