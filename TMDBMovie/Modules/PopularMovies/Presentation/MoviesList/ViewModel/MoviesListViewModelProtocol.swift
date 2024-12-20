//
//  MoviesListViewModelProtocol.swift
//  TMDBMovie
//
//  Created by Bahar on 9/28/1403 AP.
//

import UIKit
import Foundation



protocol MoviesListViewModelProtocol: AnyObject {
    
    typealias ItemsCompletionHandler = (_ didLoad: Bool, _ error: Error?) -> Void
    
    var items: [MoviesListItemViewModel]  { get }
    
    func didSelectItem(atIndex index: Int)
    
    var didSelectEntity: ((NowPlayingMovieEntity) -> Void)? { get set }
    
    func loadInitialItems(completion: @escaping  ItemsCompletionHandler)
    
    func loadMoreItemIfNeeded(completion: @escaping ItemsCompletionHandler)
    
    func search(query: String, loadingMore: Bool, completion: @escaping ItemsCompletionHandler)
    
}
