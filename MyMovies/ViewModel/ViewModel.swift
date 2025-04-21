//
//  ViewModel.swift
//  MyMovies
//
//  Created by Durgesh Mathur on 21/04/25.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var listOfMovie: [MovieModelData] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchQuery: String = ""

    private let coreService: OACoreServiceProtocol

    init(oaService: OACoreServiceProtocol = MovieService()) {
        self.coreService = oaService
    }

    @MainActor
    func fetchHomeData() async {
        isLoading = true
        do {
            let response = try await coreService.fetchMovies(pageNumber: 1)
            listOfMovie = response?.results ?? []
        } catch {
            self.errorMessage = error.localizedDescription
            print("❌ Error fetching movies: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    @MainActor
    func searchMovies(query: String) async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            await fetchHomeData()
            return
        }
        
        isLoading = true
        do {
            let response = try await coreService.searchMovies(query: query)
            listOfMovie = response?.results ?? []
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error searching movies: \(error.localizedDescription)")
        }
        isLoading = false
    }
}

