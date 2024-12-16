//
//  Response.swift
//  TMDBMovies
//
//  Created by Bahar on 9/25/1403 AP.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let posterPath: String?
    let backdropPath: String?

    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)")
    }
}
