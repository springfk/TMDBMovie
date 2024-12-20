//
//  MovieCoordinator.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403 AP.
//

import Foundation
import UIKit


class MoviesCoordinator: BaseCoordinator {
    
    var childCoordinators: [BaseCoordinator] = [] 
    var navigationController: UINavigationController
    let movieDIFactory: MovieFactory
    
    init(navigationController: UINavigationController, movieDIFactory: MovieFactory) {
        self.navigationController = navigationController
        self.movieDIFactory = movieDIFactory
    }
    
    func start() {
        let moviesListVC = movieDIFactory.makeMoviesListViewController { [weak self] movie in
            guard let self = self else { return }
            let detailVC = self.movieDIFactory.makeMovieDetailViewController(movie: movie)
            self.pushViewControllerWithAnimation(detailVC)
        }
        navigationController.pushViewController(moviesListVC, animated: true)
        
    }
    
    private func pushViewControllerWithAnimation(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = .fromTop
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        navigationController.view.layer.add(transition, forKey: kCATransition)
        navigationController.pushViewController(viewController, animated: false)
    }
}


