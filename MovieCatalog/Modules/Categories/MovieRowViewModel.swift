//
//  MovielistViewModel.swift
//  InterviewOne
//
//  Created by Bartek Hugo on 26/5/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class MovieRowViewModel {
    var movies: [Movie] = []
    var isLoading = false
    var errorMessage: String? = nil

    private var currentPage = 1
    private var canLoadMore = true

    private let loadPage: (_ page: Int) async throws -> MovieResponse
    
    init(loadPage: @escaping (_ page: Int) async throws -> MovieResponse) {
        self.loadPage = loadPage
    }

    func loadInitial() async {
        guard movies.isEmpty else { return }
        await loadMore()
    }

    func loadMore() async {
        guard !isLoading else { return }
        guard canLoadMore else { return }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let response = try await loadPage(currentPage)

            movies.append(contentsOf: response.results)

            canLoadMore = response.page < response.totalPages
            currentPage += 1
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
