//
//  BookMarkUsecase.swift
//  TMDBMovie
//
//  Created by Bahar on 9/30/1403 AP.
//

import Foundation

protocol BookmarkUsecase {
    
    func execute(bookmark: Bool, id: Int) -> Bool
    
    func isBookmarked(id: Int) -> Bool
    
}
