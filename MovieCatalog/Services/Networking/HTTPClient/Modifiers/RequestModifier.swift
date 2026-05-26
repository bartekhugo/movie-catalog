//
//  RequestModifier.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

protocol RequestModifier {
    func modify(_ request: URLRequest) -> URLRequest
}
