//
//  MovieSectionView.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import SwiftUI

struct MovieSectionView<CardProvider: MovieCardViewProviding>: View {
    let section: MovieSection
    let cardProvider: CardProvider
    
    var body: some View {
        Section(section.title) {
            
            if let error = section.viewModel.errorMessage {
                InlineErrorView(message: error) { Task { await section.viewModel.loadMore() } }
            }
            
            HorizontalCarouselView(
                items: section.viewModel.movies,
                isLoading: section.viewModel.isLoading,
                placeholder: { cardProvider.makePlacehoder(for: section.style) },
                onReachEnd: { await section.viewModel.loadMore() }
            ) { movie in
                cardProvider.makeView(for: movie, style: section.style)
            }
        }
    }
}
