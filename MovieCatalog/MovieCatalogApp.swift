//
//  MovieCatalogApp.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import SwiftUI

@main
struct MovieCatalogApp: App {
    @State private var dependencies = DIContainer()

    var body: some Scene {
        WindowGroup {
            MainFlow(dependencies: dependencies)
        }
    }
}
