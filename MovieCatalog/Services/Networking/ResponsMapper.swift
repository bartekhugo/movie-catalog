//
//  ResponsMapper.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

protocol ResponseMapping {
    func map<T: Decodable>(_ data: Data, _ response: HTTPURLResponse) throws -> T
}

final class BasicJSONMapper: ResponseMapping {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func map<T: Decodable>(_ data: Data, _ response: HTTPURLResponse) throws -> T {
        guard (200...299).contains(response.statusCode) else {
            throw NetworkError.statusCode(response.statusCode, data)
        }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(type: T.self, data: data, underlying: error)
        }
    }
}
