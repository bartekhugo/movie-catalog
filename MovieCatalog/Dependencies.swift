//
//  Dependencies.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

protocol TMDBServiceProviding {
    var tmdbService: TMDBService { get }
}

final class DIContainer: TMDBServiceProviding  {
    var tmdbService: TMDBService = DefaultTMDBService(baseURL: AppConfig.TMDBApiUrl, apiKey: AppConfig.TMDBApiKey)
}
