
//
//  MovieDetailViewModelProtocol.swift
//  TMDBMovie
//
//  Created by Bahar on 9/29/1403.
//  Copyright © 2024 TMDBMovie. All rights reserved.
//
import UIKit
import Foundation

protocol MovieDetailImageViewModelProtocol: AnyObject {
    func loadImage(completion:@escaping (UIImage?) -> Void)
}


protocol MovieDetailViewModelProtocol: MovieDetailImageViewModelProtocol {
    var name: String { get }
    var date: String{ get }
    var description: String? { get }
    var isBookmarked: Bool { get }
    func bookmark(_ bookmark: Bool)
   
    
}
