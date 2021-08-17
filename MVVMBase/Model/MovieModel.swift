//
//  MovieModel.swift
//  MVVMBase
//
//  Created by Viet Anh on 16/08/2021.
//

import Foundation

struct MovieModel: Codable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
struct Movie: Codable {
    
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

   private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


