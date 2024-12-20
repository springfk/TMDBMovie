//
//  MovieDIPool.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403 AP.
//

import Foundation
import UIKit

struct Url {
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/")!
    static let baseURL = URL(string: "https://api.themoviedb.org/3/")!
}

class MoviesDIPool: MovieFactory {
    
    
    lazy var apiClient: ApiClient = {
        let client = DefaultAPIClient.init(baseURL: Url.baseURL, configuration: .default, apiKey: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNWVmM2M0YjMwODU0M2YzYWMxMWViZDVjM2MzOTk4ZSIsIm5iZiI6MTY3NDY1MjgwNi4wODE5OTk4LCJzdWIiOiI2M2QxMmM4NmU3MmZlODAwN2NhM2E4YzAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.1o0uISkcs8H434HRNl12DsCnjOX41Md05D1LO5jffOY")
        return client
    }()
    
    lazy var movieRepository: MoviesRepositoryInterface = {
        MoviesRepository(apiClient: apiClient)
    }()
    
    lazy var bookmarkUsecase: BookmarkUsecase = {
        BookmarkUsecaseImp(repository: makeBookmarkRepository())
    }()
    
    func makeMoviesListViewController(action: @escaping (NowPlayingMovieEntity) -> Void) -> MoviesListViewRoot {
        
        let moviesListViewController = MoviesListViewRoot(viewModel: makeMovieListViewModel(action: action))
        return moviesListViewController
        
    }
 
    func makeMovieDetailViewController(movie: NowPlayingMovieEntity) -> MovieDetailSceneRoot {
        
        let imageUseCase = MovieImageUseCase(baseURL: Url.imageBaseURL, network: apiClient)
        let viewModel = MovieDetailViewModel(entity: movie, imageUsecase: imageUseCase, bookmarkUseCase: bookmarkUsecase)
        return MovieDetailSceneRoot(viewModel: viewModel)
        
    }
    
    func makeMovieListViewModel(action: @escaping (NowPlayingMovieEntity) -> Void) -> MoviesListViewModelProtocol {
        let imageUseCase = MovieImageUseCase(baseURL: Url.imageBaseURL, network: apiClient)
        let moviesUseCase = MoviesListUsecaseImp(repository: movieRepository)
        let viewModel = MoviesListViewModel(moviesListUseCase: moviesUseCase,
                                            imageUsecase: imageUseCase,
                                            didSelectEntity: action)
        viewModel.didSelectEntity = action
        return viewModel
        
    }
    
    func makeMoviesCoordinator(navigationController: UINavigationController) -> MoviesCoordinator {
        MoviesCoordinator(navigationController: navigationController, movieDIFactory: self)
    }
    
    func makeBookmarkRepository() -> BookmarksRepositoryInterface {
        BookmarkRepository()
    }
}
