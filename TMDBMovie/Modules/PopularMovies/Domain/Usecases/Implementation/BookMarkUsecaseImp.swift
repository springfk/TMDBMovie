//
//  BookMarkUsecaseImp.swift
//  TMDBMovie
//
//  Created by Bahar on 9/30/1403 AP.
//

import Foundation

final class BookmarkUsecaseImp: BookmarkUsecase {
    
    let repository : BookmarksRepositoryInterface
    
    init(repository: BookmarksRepositoryInterface) {
        self.repository = repository
    }
    
    func execute(bookmark: Bool, id: Int) -> Bool {
        if (bookmark) {
            return repository.addBookmark(for: id)
        }
        return repository.removeBookmark(atId: id)
    }
    
    func isBookmarked(id: Int) -> Bool {
        let bookmarks = repository.getBookmarks()
        return bookmarks[id] != nil && bookmarks[id]!
    }
    
}
