//
//  BookmarksRepositoryInterface.swift
//  TMDBMovie
//
//  Created by Bahar on 9/30/1403 AP.
//

import Foundation

protocol BookmarksRepositoryInterface: AnyObject {
    
    typealias Bookmarks = Dictionary<Int, Bool>
    
    // get bookmarks
    func getBookmarks() -> Bookmarks
    
    // add book
    func addBookmark(for id: Int) -> Bool
    
    // remove book mark
    func removeBookmark(atId: Int) -> Bool
}
