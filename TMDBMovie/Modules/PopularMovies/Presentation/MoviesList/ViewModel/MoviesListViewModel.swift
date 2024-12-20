//
//  MoviesListViewModel.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403 AP.
//
import Foundation

class MoviesListViewModel: MoviesListViewModelProtocol {
    
    
    private(set) var items: [any MoviesListItemViewModel] = []
    private var entities: [NowPlayingMovieEntity]
    private var allItems: [MoviesListItemViewModel] = []
    
    var didSelectEntity: ((NowPlayingMovieEntity) -> Void)?
    
    let moviesListUseCase : MoviesListUsecase
    let imageUsecase: ImageUseCase
    private var page: Int = 1
    private var searchPage: Int = 1
    
    init(moviesListUseCase: MoviesListUsecase, imageUsecase: ImageUseCase, didSelectEntity: @escaping ((NowPlayingMovieEntity) -> Void)) {
        self.entities = []
        self.didSelectEntity = didSelectEntity
        self.moviesListUseCase = moviesListUseCase
        self.imageUsecase = imageUsecase
    }
    
    func didSelectItem(atIndex index: Int) {
        
        let entity = items[index].getEntity()
        didSelectEntity?(entity)
    }
    
    func loadInitialItems(completion: @escaping ItemsCompletionHandler) {
        
        fetchMovies(atPage: 1, completion: completion)
    }
    
    func loadMoreItemIfNeeded(completion: @escaping ItemsCompletionHandler) {
        fetchMovies(atPage: page + 1, completion: completion)
    }
    
    func search(query: String, loadingMore: Bool = false, completion: @escaping ItemsCompletionHandler) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedQuery.isEmpty {
            // No search, show all
            items = allItems
            searchPage = 1
            DispatchQueue.main.async {
                completion(true, nil)
            }
        } else {
            searchMovie(query: trimmedQuery,
                        page: loadingMore ? searchPage + 1 : searchPage, completion: completion)
            
        }
    }
    
    private func fetchMovies(atPage page: Int, completion: @escaping ItemsCompletionHandler) {
        moviesListUseCase.fetchMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let moviePagination):
                let items = moviePagination.results.map { entity in
                    MoviesListItemViewCell(entity: entity, imageUsecase: self.imageUsecase)
                }
                if page == 1 {
                    self.items = items
                    self.allItems = items
                } else {
                    self.items = allItems + items
                    self.allItems += items
                }
                self.page = moviePagination.page
                DispatchQueue.main.async {
                    completion(true, nil)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(false, error)
                }
                
            }
        }
    }
    
    private func searchMovie(query: String, page: Int, completion: @escaping ItemsCompletionHandler) {
        moviesListUseCase.searchMovies(query: query, page: page) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let moviePagination):
                let items = moviePagination.results.map { entity in
                    MoviesListItemViewCell(entity: entity, imageUsecase: self.imageUsecase)
                }
                if page == 1 {
                    self.items = items
                    
                } else {
                    self.items += items
                }
                self.searchPage = moviePagination.page
                DispatchQueue.main.async {
                    completion(true, nil)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(false, error)
                }
                
            }
        }
    }
    
}
