//
//  MovieDetailViewModel.swift
//  MyMovies
//
//  Created by Durgesh Mathur on 21/04/25.
//


import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var movie: MovieModelData?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let coreService: OACoreServiceProtocol

    init(oaService: OACoreServiceProtocol = MovieService()) {
        self.coreService = oaService
    }

    @MainActor
    func fetchMovieDetails(id: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            movie = try await coreService.fetchMovieDetails(id: id)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

