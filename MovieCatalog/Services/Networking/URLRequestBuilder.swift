//
//  URLRequestBuilder.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

class URLRequestBuilder {
    let baseURL: URL
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func buildURLRequest(for endpoint: RequestDescriptor) throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endpoint.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = endpoint.queryItems
        guard let url = components?.url else {
            throw NetworkError.invalidURL(endpoint.path)
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = try endpoint.body()
        endpoint.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
}
