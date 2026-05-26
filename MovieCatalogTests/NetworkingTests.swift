//
//  MovieCatalogTests.swift
//  MovieCatalogTests
//
//  Created by Bartek Hugo on 26/5/26.
//

import Testing
import Foundation
@testable import MovieCatalog

struct TestHelpers {
    
    static func makeHTTPURLResponse(statusCode: Int) -> HTTPURLResponse {
        HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
    
}

struct NetworkingTests {

    struct URLRequestBuilderTests {
        
        @Test
        func buildsCorrectRequest() throws {
            let builder = URLRequestBuilder(baseURL: URL(string: "https://api.com")!)
            let request = try builder.buildURLRequest(for: TMDBEndpoint.nowPlaying(page: 1))
            
            #expect(request.url?.absoluteString == "https://api.com/movie/now_playing?page=1")
            #expect(request.httpMethod == "GET")
            #expect(request.httpBody == nil)
        }
    }
    
    // MARK: - JSONMapper Tests
    
    struct JSONMapperTests {
        
        @Test
        func decodesSuccessfully() throws {
            let mapper = BasicJSONMapper()
            let data = try JSONEncoder().encode(Movie.stubbedMovie)
            let response = TestHelpers.makeHTTPURLResponse(statusCode: 200)
            
            let movie: Movie = try mapper.map(data, response)
            #expect(movie.title == "Evil Dead Rise")
            #expect(movie.voteCount == 207)
            // TODO: add more checks
        }
        
        func failsOnStatusCode400() throws {
            let mapper = BasicJSONMapper()
            let data = Data()
            let response = TestHelpers.makeHTTPURLResponse(statusCode: 400)

            // TODO: Could add Equatable confomrance to Network Error
            #expect {
                try mapper.map(data, response) as MovieResponse
            } throws: { error in
                guard let networkError = error as? NetworkError else {
                    return false
                }

                if case let .statusCode(code, errorData) = networkError {
                    return code == 400 && errorData == data
                }

                return false
            }
        }
        
        @Test
        func failsOnDecodingError() throws {
            let mapper = BasicJSONMapper()
            let data = Data("invalid".utf8)
            let response = TestHelpers.makeHTTPURLResponse(statusCode: 200)
            
            var exppectation = false
            do {
                _ = try mapper.map(data, response) as MovieResponse
                exppectation = false
            } catch let error as NetworkError {
                if case .decodingFailed(let type, let data, _) = error, type == MovieResponse.self && data == data    {
                    exppectation = true
                } else {
                    exppectation = false
                }
            }
            catch {
                exppectation = false
            }
            
            #expect(exppectation)
            
            // my way or the hight way
            
            #expect(throws: NetworkError.self) {
                _ = try mapper.map(data, response) as MovieResponse
            }
        }
    }


}
