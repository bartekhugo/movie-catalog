//
//  Untitled.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

enum TMDBEndpoint: RequestDescriptor {
    case nowPlaying(page: Int)
    case popular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    
    var path: String {
        switch self {
        case .popular: return "/movie/popular"
        case .topRated: return "/movie/top_rated"
        case .upcoming: return "/movie/upcoming"
        case .nowPlaying: return "/movie/now_playing"
        }
    }
        
    var queryItems: [URLQueryItem]? {
        switch self {
        case .nowPlaying(let page),
             .popular(let page),
             .topRated(let page),
             .upcoming(let page):
            
            return [URLQueryItem(name: "page", value: "\(page)")]
        }
    }

    var method: HTTPMethod {
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming:  return .GET
        }
    }

}
