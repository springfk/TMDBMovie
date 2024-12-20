//
//  AppCoordinator.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403 AP.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    
    var childCoordinators: [any BaseCoordinator] = []
    
    
    var navigationViewController : UINavigationController
    var appDIPool : AppDIPool
    
    init(navigationViewController: UINavigationController, appDIPool: AppDIPool) {
        self.navigationViewController = navigationViewController
        self.appDIPool = appDIPool
    }
    
    func start() {
        let movieDiPool = appDIPool.makeMovieDIPool()
        let moviesCoordinator = movieDiPool.makeMoviesCoordinator(navigationController: navigationViewController)
        childCoordinators.append(moviesCoordinator)
        moviesCoordinator.start()
        
    }
}
