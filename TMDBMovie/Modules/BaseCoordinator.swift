//
//  BaseCoordinator.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403 AP.
//

import Foundation
import UIKit

protocol BaseCoordinator {
    func start()
    var childCoordinators: [BaseCoordinator] { get }
}
