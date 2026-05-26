//
//  Movie.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

// These models mirror the TMDB API response structure directly.
// They are intentionally kept simple and tightly coupled to the API.
// For the current scope of this project, I skip the DTO → Domain mapping
// to avoid unnecessary complexity and boilerplate.
// In a larger architecture, these would typically be treated as DTOs
// and mapped into separate domain models used by the app layer.

struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }

}
