//
//  MovieSection.swift
//  MovieCatalog
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation

struct MovieSection: Identifiable {
    let id = UUID()
    
    let title: String
    let style: Style
    let viewModel: MovieRowViewModel
    
    enum Style {
        case backdrop(columns: Int, hideTitle: Bool)
        case poster(columns: Int)
    }
}
