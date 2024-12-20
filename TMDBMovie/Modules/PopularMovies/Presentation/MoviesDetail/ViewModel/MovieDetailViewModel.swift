
//
//  MovieDetailViewModel.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403.
//  Copyright © 2024 TMDBMovie. All rights reserved.
//
import UIKit
import Foundation

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var name: String {
        entity.originalTitle
    }
    
    var date: String {
        entity.releaseDate
    }
    
    var description: String? {
        entity.overview
    }
    
    var isBookmarked: Bool {
        bookmarkUseCase.isBookmarked(id: entity.id)
    }

   
    let imageUsecase: ImageUseCase
    let entity: NowPlayingMovieEntity
    let bookmarkUseCase: BookmarkUsecase
    
    init(entity: NowPlayingMovieEntity,
         imageUsecase: ImageUseCase,
         bookmarkUseCase: BookmarkUsecase
        ) {
        self.imageUsecase = imageUsecase
        self.entity = entity
        self.bookmarkUseCase = bookmarkUseCase
    }
    
    func bookmark(_ bookmark: Bool) {
        _ = bookmarkUseCase.execute(bookmark: bookmark, id: entity.id)
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = entity.backdropPath ?? entity.posterPath else {
            return
        }
        
        imageUsecase.getImageData(for: imageUrl, type: .poster) { image, error in
            
            guard let data = image, let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}

extension MovieDetailViewModel: MovieDetailImageViewModelProtocol {}
