//
//  BookmarkRepository.swift
//  TMDBMovie
//
//  Created by Bahar on 9/30/1403 AP.
//

import Foundation

final class BookmarkRepository: BookmarksRepositoryInterface {
    
    // in memory cache
    private var cache: Bookmarks = [:]
    
    func getBookmarks() -> Bookmarks {
        return cache
    }
    
    func addBookmark(for id: Int) -> Bool {
        cache[id] = true
        return true
    }
    
    func removeBookmark(atId id: Int) -> Bool {
        cache[id] = nil
        // space complexity o(n)
        // cache[id] = false
        return true
    }
    
}
