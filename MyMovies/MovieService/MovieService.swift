//
//  MovieService.swift
//  MyMovies
//
//  Created by Durgesh Mathur on 21/04/25.
//


class MovieService : OACoreServiceProtocol {

    private var networkService: OANetworkServiceProtocol
    init(networkService: OANetworkServiceProtocol = OANetworkService()) {
        self.networkService = networkService
    }
    
    func fetchMovies(pageNumber: Int) async throws -> MovieModel? {
        let endpoint = OAEndpoint.fetchMovies(apiKey: AppConfig.apiKey)
        do {
            return try await networkService.sendRequest(endpoint: endpoint)
        } catch {
            throw error
        }
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieModelData? {
        let endpoint = OAEndpoint.fetchMovieDetails(id: id, apiKey: AppConfig.apiKey)
        do {
            return try await networkService.sendRequest(endpoint: endpoint)
        } catch {
            throw error
        }
    }
    
    func searchMovies(query: String) async throws -> MovieModel? {
        let endpoint = OAEndpoint.searchMovies(query: query, apiKey: AppConfig.apiKey)
        do {
            return try await networkService.sendRequest(endpoint: endpoint)
        } catch {
            throw error
        }
    }
    
   
   
}
