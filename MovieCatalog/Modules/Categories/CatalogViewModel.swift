//
//  CatalogViewModel.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Observation
import Foundation

@MainActor
@Observable
final class CatalogViewModel {
    private(set) var sections: [MovieSection] = []
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String? = nil
    
    private let sectionProvider: CatalogSectionsProviding
    
    init(sectionProvider: CatalogSectionsProviding) {
        self.sectionProvider = sectionProvider
    }
    
    func load() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        sections = sectionProvider.makeSections()
        
        await withTaskGroup(of: Void.self) { group in
            for section in sections {
                group.addTask {
                    await section.viewModel.loadInitial()
                }
            }
        }
        
        errorMessage = sections
            .compactMap { $0.viewModel.errorMessage }
            .first
    }
}

// MARK: - Previe

extension CatalogViewModel {
    static let empty = CatalogViewModel(sectionProvider: EmptyCatalogSectionsProvider())
    static let error = CatalogViewModel(sectionProvider: ErrorCatalogSectionsProvider())
}


@MainActor
struct EmptyCatalogSectionsProvider: CatalogSectionsProviding {
    func makeSections() -> [MovieSection] {
        []
    }
}

@MainActor
struct ErrorCatalogSectionsProvider: CatalogSectionsProviding {
    func makeSections() -> [MovieSection] {
        [MovieSection(
            title: "Now Playing",
            style: .backdrop(
                columns: 3,
                hideTitle: false
            ),
            viewModel: .error())
        ]
    }
}

extension MovieRowViewModel {
    static func error() -> MovieRowViewModel {
        MovieRowViewModel(loadPage: { _ in
            throw URLError(.notConnectedToInternet)
        })
    }
}
