//
//  APIKeyModifier.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

final class APIKeyModifier: RequestModifier {
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func modify(_ request: URLRequest) -> URLRequest {
        var request = request
        var components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)

        var items = components?.queryItems ?? []
        items.append(URLQueryItem(name: "api_key", value: apiKey))
        components?.queryItems = items

        request.url = components?.url
        return request
    }
}
