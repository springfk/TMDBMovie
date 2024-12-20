//
//  MoviesRepository.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403 AP.
//

import Foundation

class MoviesRepository: MoviesRepositoryInterface {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getMoviesList(page: Int, completion: @escaping (Result<MoviePagination, Error>) -> Void) {
        
        do {
            let endpoint = TMDBAnyRequest(path: "movie/now_playing",
                                          queryParameters: ["page": page])
            try apiClient.request(endpoint: endpoint) {
                (result: Result<MoviePaginationDTO, APIError>) in
                
                switch result {
                case .success(let moviePaginationDTO):
                    let results = moviePaginationDTO.results.map {
                        NowPlayingMovieEntity(adult: $0.adult, backdropPath: $0.backdropPath, genreIds: $0.genreIds, id: $0.id, originalLanguage: $0.originalLanguage, originalTitle: $0.originalTitle, overview: $0.overview, popularity: $0.popularity, posterPath: $0.posterPath, releaseDate: $0.releaseDate, title: $0.title, video: $0.video, voteAverage: $0.voteAverage, voteCount: $0.voteCount)
                    }
                    let pagination = MoviePagination(dates: moviePaginationDTO.dates,
                                                     page: moviePaginationDTO.page,
                                                     results: results,
                                                     totalPages: moviePaginationDTO.totalPages,
                                                     totalResults: moviePaginationDTO.totalResults)
                    completion(.success(pagination))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
            return
        }
    }
    
   
    func searchMovies(query: String, page: Int,
                      completion: @escaping (Result<MoviePagination, Error>) -> Void) {
        let endpoint = TMDBAnyRequest(path: "search/movie",
                                      queryParameters: ["query": query, "page": page])
        do {
            try apiClient.request(endpoint: endpoint,
                                  completion: { (result: Result<MoviePaginationDTO, APIError>) in
                switch result {
                case .success(let moviePaginationDTO):
                    let results = moviePaginationDTO.results.map {
                        NowPlayingMovieEntity(adult: $0.adult, backdropPath: $0.backdropPath, genreIds: $0.genreIds, id: $0.id, originalLanguage: $0.originalLanguage, originalTitle: $0.originalTitle, overview: $0.overview, popularity: $0.popularity, posterPath: $0.posterPath, releaseDate: $0.releaseDate, title: $0.title, video: $0.video, voteAverage: $0.voteAverage, voteCount: $0.voteCount)
                    }
                    let pagination = MoviePagination(dates: moviePaginationDTO.dates,
                                                     page: moviePaginationDTO.page,
                                                     results: results,
                                                     totalPages: moviePaginationDTO.totalPages,
                                                     totalResults: moviePaginationDTO.totalResults)
                    completion(.success(pagination))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        } catch let error {
            completion(.failure(error))
            return
        }
    }
    
}
