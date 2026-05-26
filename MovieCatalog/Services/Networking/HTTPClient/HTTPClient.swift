//
//  HTTPClient.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

protocol HTTPClient {
    func execute(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)
}
