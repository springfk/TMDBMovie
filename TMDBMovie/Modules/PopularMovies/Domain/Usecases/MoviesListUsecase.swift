//
//  MoviesListUsecase.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403 AP.
//

import Foundation

protocol MoviesListUsecase {
    
    func fetchMovies(page: Int, completion: @escaping (Result<MoviePagination, Error>) -> Void)
    func searchMovies(query: String, page: Int, completion: @escaping (Result<MoviePagination, Error>) -> Void)    
}
