//
//  TMDBService.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

protocol TMDBService {
    func nowPlaying(page: Int) async throws -> MovieResponse
    func popular(page: Int) async throws -> MovieResponse
    func topRated(page: Int) async throws -> MovieResponse
    func upcoming(page: Int) async throws -> MovieResponse
}

final class DefaultTMDBService: TMDBService {
    private let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
            
    func nowPlaying(page: Int = 1) async throws -> MovieResponse {
        try await service.send(TMDBEndpoint.nowPlaying(page: page))
    }
    
    func popular(page: Int = 1) async throws -> MovieResponse {
        try await service.send(TMDBEndpoint.popular(page: page))
    }
    
    func topRated(page: Int = 1) async throws -> MovieResponse {
        try await service.send(TMDBEndpoint.topRated(page: page))
    }
 
    func upcoming(page: Int = 1) async throws -> MovieResponse {
        try await service.send(TMDBEndpoint.upcoming(page: page))
    }
 }

extension DefaultTMDBService {
    convenience init(baseURL: URL, apiKey: String) {
        let mapper = BasicJSONMapper(decoder: JSONDecoder.tmdbDecoder)
        let requestBuilder = URLRequestBuilder(baseURL: baseURL)
        let client = ModifiableHTTPClient(client: URLSessionHTTPClient(),
                                          modifiers: [APIKeyModifier(apiKey: apiKey)])
        let service = DefaultNetworkService(httpClient: client,
                                            requestBuilder: requestBuilder,
                                            mapper: mapper)
        self.init(service: service)
    }
}
