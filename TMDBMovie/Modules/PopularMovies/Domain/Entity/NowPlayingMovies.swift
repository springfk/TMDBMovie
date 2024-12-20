//
//  nowPlayingMovies.swift
//  TMDBMovie
//
//  Created by Bahar on 9/27/1403 AP.
//

import Foundation

// MARK: - Main Response
struct MoviePagination {
    let dates: Dates?
    let page: Int
    let results: [NowPlayingMovieEntity]
    let totalPages: Int
    let totalResults: Int
    
}

// MARK: - Dates
struct Dates: Codable {
    let maximum: String
    let minimum: String
}

// MARK: - Movie
struct NowPlayingMovieEntity: Codable {

    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    
    internal init(adult: Bool, backdropPath: String? = nil, genreIds: [Int], id: Int, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String? = nil, releaseDate: String, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)")
    }
}


