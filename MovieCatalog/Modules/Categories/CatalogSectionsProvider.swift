//
//  CatalogSectionsProviding.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

protocol CatalogSectionsProviding {
    func makeSections() -> [MovieSection]
}

@MainActor
struct CatalogSectionsProvider: CatalogSectionsProviding {
    private let tmdb: TMDBService
    
    init(tmdb: TMDBService) {
        self.tmdb = tmdb
    }
    
    func makeSections() -> [MovieSection] {
        [
            MovieSection(
                title: "Now Playing",
                style: .backdrop(
                    columns: 3,
                    hideTitle: false
                ),
                viewModel: MovieRowViewModel(
                    loadPage: tmdb.nowPlaying
                )
            ),
            
            MovieSection(
                title: "Top Rated",
                style: .poster(columns: 4),
                viewModel: MovieRowViewModel(
                    loadPage: tmdb.topRated
                )
            ),
            
            MovieSection(
                title: "Popular",
                style: .backdrop(
                    columns: 5,
                    hideTitle: true
                ),
                viewModel: MovieRowViewModel(
                    loadPage: tmdb.popular
                )
            ),
            
            MovieSection(
                title: "Upcoming",
                style: .poster(columns: 6),
                viewModel: MovieRowViewModel(
                    loadPage: tmdb.upcoming
                )
            )
        ]
    }
}
