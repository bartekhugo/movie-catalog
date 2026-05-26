//
//  JSONDecoder+Extensions.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

extension JSONDecoder {
    static let tmdbDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)
        return decoder
    }()
}
