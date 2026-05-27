//
//  Catalog.swift
//  InterviewOne
//
//  Created by Bartek Hugo on 26/5/26.
//

import SwiftUI

struct CatalogView: View {
    @State private var viewModel: CatalogViewModel
    
    init(viewModel: CatalogViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.sections) { section in
                    MovieSectionView(
                        section: section,
                        cardProvider: DefaultMovieCardViewProvider()
                    )
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    CatalogView(viewModel: CatalogViewModel(sectionProvider: CatalogSectionsProvider(tmdb: DIContainer().tmdbService)))
}
