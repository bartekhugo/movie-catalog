//
//  MainFlow.swift
//  InterviewOne
//
//  Created by Bartek Hugo on 25/5/26.
//

import SwiftUI
import Observation

struct MainFlow: View {

    typealias Dependencies = TMDBServiceProviding
    private var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    var body: some View {
        NavigationStack {
            CatalogView(viewModel: CatalogViewModel(sectionProvider: CatalogSectionsProvider(tmdb: dependencies.tmdbService)))
        }
    }
}

#Preview {
    MainFlow(dependencies: DIContainer())
}

