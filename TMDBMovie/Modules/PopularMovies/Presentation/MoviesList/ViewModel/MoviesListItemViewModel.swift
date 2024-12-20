//
//  MoviesListItemViewModel.swift
//  TMDBMovie
//
//  Created by Bahar on 9/28/1403 AP.
//

import Foundation
import UIKit


protocol MoviesListItemViewModel {
    
    var name: String { get }
    var date: String {  get }
    func getIconImage(completion:@escaping (_ image: UIImage?) -> Void)
    func getEntity() -> NowPlayingMovieEntity
    
}


struct MoviesListItemViewCell: MoviesListItemViewModel {
    let imageUsecase: ImageUseCase
    let movieEntity: NowPlayingMovieEntity
    
    var name: String {
        movieEntity.originalTitle
    }
    
    var date: String {
        movieEntity.releaseDate
    }
    
    init(entity: NowPlayingMovieEntity, imageUsecase: ImageUseCase) {
        self.imageUsecase = imageUsecase
        self.movieEntity = entity
        //        date = convertUnixToDate(entity.date_Unix)
    }
    
    func getEntity() -> NowPlayingMovieEntity {
        return movieEntity
    }
    
    func getIconImage(completion: @escaping (UIImage?) -> Void) {
        print("getIconImage")
        guard let imageUrl = movieEntity.posterPath else {
            return
        }
        
        imageUsecase.getImageData(for: imageUrl, type: .poster) { image, error in
            print("image error :",error)
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
