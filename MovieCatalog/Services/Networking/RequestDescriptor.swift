//
//  RequestDescriptor.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

enum HTTPMethod: String { case GET, POST, PUT, PATCH, DELETE }

protocol RequestDescriptor {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    
    func body() throws -> Data?
}

extension RequestDescriptor {
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    
    func body() throws -> Data? { nil }
}
