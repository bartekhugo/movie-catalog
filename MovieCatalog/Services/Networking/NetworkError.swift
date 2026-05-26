//
//  NetworkError.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

enum NetworkError: Error {
    case badResponse
    case statusCode(Int, Data)
    case invalidURL(String)
    case decodingFailed(type: Any.Type, data: Data, underlying: Error)
    case requestFailed(endpoint: String, underlying: Error)
}
