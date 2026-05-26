//
//  Config.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//


import Foundation

enum AppConfig {
    
    private enum Keys {
        static let tmdbApiUrl = "TMDB_API_URL"
        static let tmdbApiKey = "TMDB_API_KEY"
        static let tmdbApiUrlScheme = "TMDB_API_URL_SCHEME"
    }

    static var TMDBApiUrl: URL {
        return URL(string: "\(string(Keys.tmdbApiUrlScheme))://\(string(Keys.tmdbApiUrl))")!
    }

    static var TMDBApiKey: String {
        return string(Keys.tmdbApiKey)
    }
}

extension AppConfig {
    private static func string(_ key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            fatalError("Missing config key: \(key)")
        }
        return value
    }
}
