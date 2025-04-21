//
//  ContentView.swift
//  MyMovies
//
//  Created by Durgesh Mathur on 21/04/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.listOfMovie) { movie in
                        NavigationLink(destination: MovieDetailView(movieID: movie.id ?? 0)) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
            }
            .navigationTitle("Movies")
            .searchable(text: $viewModel.searchQuery, prompt: "Search Movies")
            .onChange(of: viewModel.searchQuery) { newQuery in
                Task {
                    await viewModel.searchMovies(query: newQuery)
                }
            }
            .task {
                await viewModel.fetchHomeData()
            }
        }
    }
}


struct MovieRowView: View {
    let movie: MovieModelData

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100)
                .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title ?? "")
                    .font(.headline)
                Text(movie.overview ?? "")
                    .font(.subheadline)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}
