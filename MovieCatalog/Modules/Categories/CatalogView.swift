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
        ZStack {
            if viewModel.isLoading {
                progressView
            }
            else if let error = viewModel.errorMessage {
                noContentView(title: "Unable to Load Movies",
                              message:"""
                                        We couldn’t fetch the movie catalog right now. 
                                        Please check your internet connection and try again.
                                        Error: \(error)
                                        """)
            }
            else if viewModel.sections.allSatisfy({ $0.viewModel.movies.isEmpty }) {
                noContentView(title: "No Movies",
                              message: "There are no movies available right now.")
            }
            else {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.sections.filter { !$0.viewModel.movies.isEmpty } ) { section in
                            MovieSectionView(
                                section: section,
                                cardProvider: DefaultMovieCardViewProvider()
                            )
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
    
    private var progressView: some View {
        VStack(spacing: 32) {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
            
            Text("Loading Movies…")
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
    
    private func noContentView(title: String, message: String) -> some View {
        ContentUnavailableView {
            Label(title, systemImage: "movieclapper")
        } description: {
            Text(message)
        } actions: {
            Button { Task { await viewModel.load()}
            } label: {
                Label("Retry", systemImage: "arrow.clockwise")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview("Content") {
    CatalogView(viewModel: CatalogViewModel(sectionProvider: CatalogSectionsProvider(tmdb: DIContainer().tmdbService)))
}

#Preview("Empty") {
    CatalogView(viewModel: .empty)
}

#Preview("Error") {
    CatalogView(viewModel: .error)
}
