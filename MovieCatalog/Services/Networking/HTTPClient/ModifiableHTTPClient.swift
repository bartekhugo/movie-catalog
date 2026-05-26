//
//  ModifiableHTTPClient.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

final class ModifiableHTTPClient: HTTPClient {
    private let client: HTTPClient
    private let modifiers: [RequestModifier]
    
    init(client: HTTPClient, modifiers: [RequestModifier]) {
        self.client = client
        self.modifiers = modifiers
    }

    func execute(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let modified = modifiers.reduce(request) { req, modifier in
            modifier.modify(req)
        }
        return try await client.execute(modified)
    }
}
