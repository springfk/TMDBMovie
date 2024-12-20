//
//  MoviesSceneFactory.swift
//  TMDBMovie
//
//  Created by Bahar on 9/27/1403 AP.
//

import Foundation
import UIKit

protocol MovieFactory {
    func makeMoviesListViewController(action:@escaping (NowPlayingMovieEntity) -> Void) -> MoviesListViewRoot
    func makeMovieDetailViewController(movie: NowPlayingMovieEntity) -> MovieDetailSceneRoot
}
