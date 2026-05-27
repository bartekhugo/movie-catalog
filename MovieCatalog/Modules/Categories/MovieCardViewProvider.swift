//
//  MovieCardViewProviding.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import SwiftUI

protocol MovieCardViewProviding {
    associatedtype Content: View
    associatedtype Placeholder: View

    @ViewBuilder
    func makeView(for movie: Movie, style: MovieSection.Style) -> Content
    
    @ViewBuilder
    func makePlacehoder(for style: MovieSection.Style) -> Placeholder
}

struct DefaultMovieCardViewProvider: MovieCardViewProviding {
    
    @ViewBuilder
    func makeView(for movie: Movie, style: MovieSection.Style) -> some View {
        switch style {
        case .backdrop(let columns, let hideTitle):
            BackdropCard(movie: movie,titleHidden: hideTitle)
                .containerRelativeFrame(.horizontal,
                                        count: columns,
                                        spacing: 40)            
        case .poster(let columns):
            PosterCard(movie: movie)
                .containerRelativeFrame(.horizontal,
                                        count: columns,
                                        spacing: 40)
        }
    }
    
    @ViewBuilder
    func makePlacehoder(for style: MovieSection.Style) -> some View {
        switch style {
        case .backdrop(let columns, _):
            Rectangle()
                .fill(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .aspectRatio(16/9, contentMode: .fit)
                .containerRelativeFrame(.horizontal,
                                        count: columns,
                                        spacing: 40)
        case .poster(let columns):
            Rectangle()
                .fill(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .aspectRatio(2/3, contentMode: .fit)
                .containerRelativeFrame(.horizontal,
                                        count: columns,
                                        spacing: 40)
        }
    }

}
