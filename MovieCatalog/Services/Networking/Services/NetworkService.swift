//
//  NetworkService.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

protocol NetworkService {
    func send<T: Decodable>(_ endpoint: RequestDescriptor) async throws -> T
}

final class DefaultNetworkService: NetworkService {
    private let httpClient: HTTPClient
    private let requestBuilder: URLRequestBuilder
    private let mapper: ResponseMapping
    
    init(httpClient: HTTPClient, requestBuilder: URLRequestBuilder, mapper: ResponseMapping) {
        self.httpClient = httpClient
        self.requestBuilder = requestBuilder
        self.mapper = mapper
    }
    
    func send<T: Decodable>(_ endpoint: RequestDescriptor) async throws -> T {
        do {
            let request = try requestBuilder.buildURLRequest(for: endpoint)
            let (data, response) = try await httpClient.execute(request)
            return try mapper.map(data, response)
        } catch {
            throw NetworkError.requestFailed(endpoint: endpoint.path, underlying: error)
        }
    }
}
