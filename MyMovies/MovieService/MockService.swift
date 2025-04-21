//
//  MockService.swift
//  MyMovies
//
//  Created by Durgesh Mathur on 21/04/25.
//

import Foundation

// Mock Movie Service
class MockMovieService: OACoreServiceProtocol {

    
    var shouldReturnError = false
    var mockMovies: [MovieModelData] = []

    func fetchMovies(pageNumber: Int) async throws -> MovieModel? {
        if shouldReturnError {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mocked error fetching movies"])
        } else {
            return MovieModel(results: mockMovies)
        }
    }

    func searchMovies(query: String) async throws -> MovieModel? {
        if shouldReturnError {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mocked error searching movies"])
        } else {
            return MovieModel(results: mockMovies.filter { $0.title?.contains(query) ?? false })
        }
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieModelData? {
        return nil
    }
    
}
