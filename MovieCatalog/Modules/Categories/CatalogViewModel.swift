//
//  CatalogViewModel.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Observation

@MainActor
@Observable
final class CatalogViewModel {
    private(set) var sections: [MovieSection] = []
    
    private let sectionProvider: CatalogSectionsProviding
    
    init(sectionProvider: CatalogSectionsProviding) {
        self.sectionProvider = sectionProvider
    }
    
    func load() async {
        sections = sectionProvider.makeSections()
        
        // loading one by one imho works better always focus on the first row for free
        for section in sections {
            await section.viewModel.loadInitial()
        }
    }
}
